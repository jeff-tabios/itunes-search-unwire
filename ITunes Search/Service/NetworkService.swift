//
//  NetworkService.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import Foundation
import Combine

protocol NetworkServiceProtocol {
    func loadData<T: Decodable>(urlString: String, parameters: Any?) throws -> AnyPublisher<T, Error>
}

final class NetworkService: NetworkServiceProtocol {
    func loadData<T: Decodable>(urlString: String, parameters: Any?) throws -> AnyPublisher<T, Error> {
        do {
            let url = try urlRequest(urlString: urlString, parameters: parameters)
            return URLSession.shared.dataTaskPublisher(for: url)
                .receive(on: DispatchQueue.main)
                .tryMap(handleOutput)
                .decode(type: T.self, decoder: JSONDecoder())
                .eraseToAnyPublisher()
        } catch {
            throw error
        }
    }

    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }

    func urlRequest(urlString: String, parameters: Any?) throws -> URLRequest {
        guard var urlComponents = URLComponents(string: urlString) else {
            throw URLError(.badURL)
        }

        if let parameters = parameters as? [String: Any] {
            let queryItems: [URLQueryItem] = parameters.compactMap({
                guard let value = $0.value as? String else { return nil }
                return URLQueryItem(name: $0.key, value: value)
            })
            urlComponents.queryItems = queryItems
        }

        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }

        return URLRequest(url: url)
    }
}
