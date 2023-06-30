//
//  SearchResultCell.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import Foundation
import UIKit

final class SearchResultCell: UITableViewCell {
    lazy var artwork: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()

    private let releaseDate = UILabel()
    private let trackName = UILabel()
    private let artistName = UILabel()
    private let shortDescription = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        artwork.image = UIImage()
        releaseDate.text = ""
        trackName.text = ""
        artistName.text = ""
        shortDescription.text = ""
    }
}

// MARK: Configuration
extension SearchResultCell {
    func configure(song: Song) {
        var shortDescriptionText = ""
        if let songGenre = song.primaryGenreName {
            shortDescriptionText = "Genre: \(songGenre)"
        }
        if let explicit = song.trackExplicitness {
            shortDescriptionText += " (\(explicit))"
        }

        artwork.load(url: URL(string: song.artworkUrl100)!)
        releaseDate.text = "Released: \(song.releaseDate?.formattedDate ?? "")"
        trackName.text = song.trackName
        artistName.text = "By: \(song.artistName)"
        shortDescription.text = shortDescriptionText

        addSubview(artwork)
        addSubview(releaseDate)
        addSubview(trackName)
        addSubview(artistName)
        addSubview(shortDescription)
        configureSubviews()
    }

    func configureSubviews() {
        artwork.translatesAutoresizingMaskIntoConstraints = false
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        trackName.translatesAutoresizingMaskIntoConstraints = false
        artistName.translatesAutoresizingMaskIntoConstraints = false
        shortDescription.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            artwork.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            artwork.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            artwork.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            artwork.widthAnchor.constraint(equalToConstant: 104),
            artwork.heightAnchor.constraint(greaterThanOrEqualToConstant: 104),

            trackName.topAnchor.constraint(equalTo: artwork.topAnchor),
            trackName.leadingAnchor.constraint(equalTo: artwork.trailingAnchor, constant: 8),

            artistName.topAnchor.constraint(equalTo: trackName.bottomAnchor, constant: 8),
            artistName.leadingAnchor.constraint(equalTo: artwork.trailingAnchor, constant: 8),

            releaseDate.topAnchor.constraint(equalTo: artistName.bottomAnchor, constant: 8),
            releaseDate.leadingAnchor.constraint(equalTo: artwork.trailingAnchor, constant: 8),

            shortDescription.bottomAnchor.constraint(equalTo: artwork.bottomAnchor),
            shortDescription.leadingAnchor.constraint(equalTo: artwork.trailingAnchor, constant: 8),

        ])
    }
}
