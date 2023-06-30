//
//  String+.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/30/23.
//

import Foundation

extension String {
    var formattedDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        if let dateObj = dateFormatterGet.date(from: self) {
            return dateFormatter.string(from: dateObj)
        }

        return self
    }
}
