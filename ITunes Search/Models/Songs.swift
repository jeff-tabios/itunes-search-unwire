//
//  Songs.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import Foundation

// MARK: - Songs
struct Songs: Codable {
    let resultCount: Int
    let results: [Song]
}

// MARK: - Result
struct Song: Codable {
    let artistName: String
    let trackName: String
    let artworkUrl100: String
    let releaseDate: String?
    let trackExplicitness: String?
    let trackTimeMillis: Int?
    let country: String?
    let currency: String?
    let primaryGenreName: String?
    let isStreamable: Bool?

    enum CodingKeys: String, CodingKey {
        case artistName, trackName, artworkUrl100, releaseDate, trackExplicitness, trackTimeMillis, country, currency, primaryGenreName, isStreamable
    }
}
