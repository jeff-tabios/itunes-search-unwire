//
//  ITunes_SearchTests.swift
//  ITunes SearchTests
//
//  Created by Jeffrey Tabios on 6/29/23.
//

import XCTest
import Combine
@testable import ITunes_Search

final class ITunes_SearchTests: XCTestCase {

    // A Sample Test
    func test_Get_Items_Data_Should_Get_Item() {
        let client = SearchClient(service: MockService())
        let sut = SearchViewModel(client: client)
        var cancellables = Set<AnyCancellable>()
        let exp = expectation(description: "Get data")
        sut.search(term: "term")
        sut.state
            .sink { completion in
                print(completion)
            } receiveValue: { _ in
                exp.fulfill()
            }.store(in: &cancellables)

        wait(for: [exp], timeout: 3)
        XCTAssertEqual(sut.state.value.currentSongs.count, 1)
    }
}
