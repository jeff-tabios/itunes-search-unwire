//
//  SearchClient.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import Foundation
import Combine

protocol SearchClientProtocol {
    func search(query: String) throws -> AnyPublisher<Songs, Error>
}

class SearchClient: SearchClientProtocol {
    let service: NetworkServiceProtocol
    let urlString: String
    var parameters: [String: String]

    init(service: NetworkServiceProtocol = NetworkService()) {
        self.service = service
        urlString = "https://itunes.apple.com/search"
        parameters = [
            "country": "dk",
            "limit": "20",
            "media": "music"
        ]
    }

    func search(query: String) throws -> AnyPublisher<Songs, Error> {
        parameters["term"] = query

        do {
            let songs: AnyPublisher<Songs, Error> = try service.loadData(urlString: urlString, parameters: parameters)
            return songs
        } catch {
            throw error
        }
    }
}
