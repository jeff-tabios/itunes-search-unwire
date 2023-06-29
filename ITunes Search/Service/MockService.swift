//
//  MockService.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/30/23.
//

import Foundation
import Combine

final class MockService: NetworkServiceProtocol {
    var mockItemsData: [Song]
    var mockData: Songs

    init() {
        mockItemsData = [
            Song(artistName: "Adele",
                 trackName: "Hello",
                 artworkUrl100: "https://someurl.co/image.jpg",
                 releaseDate: "34534534564356",
                 trackExplicitness: "explicit",
                 trackTimeMillis: 218271,
                 country: "DNK",
                 currency: "DKK",
                 primaryGenreName: "Pop",
                 isStreamable: true)
        ]
        mockData = Songs(resultCount: 1, results: mockItemsData)
    }

    func loadData<T>(urlString: String, parameters: Any?) throws -> AnyPublisher<T, Error> where T : Decodable {
        return Just(mockData as! T)
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
    }
}
