//
//  SearchViewModel.swift
//  ITunes Search
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import Foundation
import Combine

enum SearchState {
    case idle
    case searching
    case done
}

protocol SearchViewProtocol {
    var results: CurrentValueSubject<[Song], Never> { get }
    func search(term: String)
}

final class SearchViewModel: SearchViewProtocol {
    private(set) var viewState: SearchState = .idle
    let results = CurrentValueSubject<[Song], Never>([])
    private var subscriptions: Set<AnyCancellable> = []

    func search(term: String) {

    }
}
