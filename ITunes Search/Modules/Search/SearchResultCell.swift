//
//  SearchResultCell.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import Foundation
import UIKit

final class SearchResultCell: UITableViewCell {
    private let songName = UILabel.init(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: Configuration
extension SearchResultCell {
    func configure(song: Song) {
        songName.numberOfLines = 0
        songName.textAlignment = .center
        songName.lineBreakMode = .byWordWrapping
        songName.text = song.trackName

        addSubview(songName)
        songName.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            songName.centerXAnchor.constraint(equalTo: centerXAnchor),
            songName.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            songName.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            songName.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
