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
    case done(songs: [Song])

    var currentSongs: [Song] {
        switch self {
        case .done(let songs):
            return songs
        default:
            return []
        }
    }
}

protocol SearchViewProtocol {
    var state: CurrentValueSubject<SearchState, Error> { get }
    func search(term: String)
}

final class SearchViewModel: SearchViewProtocol {
    let client: SearchClientProtocol
    let state = CurrentValueSubject<SearchState, Error>(.idle)
    private var searchCancellable: AnyCancellable?

    init(client: SearchClientProtocol = SearchClient()) {
        self.client = client
    }

    func search(term: String) {
        guard !term.isEmpty else {
            state.send(.idle)
            return
        }

        state.send(.searching)
        do {
            searchCancellable = try client.search(query: term)
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .failure(let error):
                        print(error)
                        self?.state.send(completion: .failure(error))
                    case .finished:
                        print("finished client")
                    }
                }, receiveValue: { [weak self] songs in
                    self?.state.send(.done(songs: songs.results))
                })
        } catch {
            print(error)
            state.send(completion: .failure(error))
        }
    }
}
