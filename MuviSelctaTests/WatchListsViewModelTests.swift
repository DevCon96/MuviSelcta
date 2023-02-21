//
//  WatchListsViewModelTests.swift
//  MuviSelctaTests
//
//  Created by Connor Jones on 10/02/2023.
//

import XCTest
@testable import MuviSelcta

final class WatchListsViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    @MainActor func testCreateWatchlist() throws {
        // Given
        let newWatchListName = "Test Watchlist"
        let viewModel = WatchListsView.WatchListViewModel()
        let currentWatchListCount = viewModel.watchLists.count

        // When
        viewModel.createWatchList(name: newWatchListName)

        // Then
        XCTAssertTrue(viewModel.watchLists.count > 0, "Watch list is currently empty")
        XCTAssertEqual(viewModel.watchLists.count, (currentWatchListCount + 1), "No new watch list was added to group")
        guard viewModel.watchLists.count > currentWatchListCount else {
            XCTFail("Index out of bounds")
            return
        }

        XCTAssertEqual(viewModel.watchLists[currentWatchListCount], newWatchListName, "End item on watch lists group is not the new one")
    }

    @MainActor func testDeleteWatchlist() throws {
        // Given
        let watchListNameTest = "Delete Me..."
        let viewModel = WatchListsView.WatchListViewModel()
        viewModel.createWatchList(name: watchListNameTest)

        XCTAssertEqual(viewModel.watchLists.first, watchListNameTest, "Test watchlist has not been added")
        // When
        viewModel.deleteWatchList(name: watchListNameTest)

        // Then
        XCTAssertFalse(viewModel.watchLists.contains(watchListNameTest), "Watchlist is still present")
    }

    @MainActor func testDuplicatingWatchlist() throws {
        // Given
        let watchlistTestName = "Duplicate Me?"
        let viewModel = WatchListsView.WatchListViewModel()
        viewModel.createWatchList(name: watchlistTestName)

        // When
        viewModel.createWatchList(name: watchlistTestName)

        // Then
        XCTAssertEqual(viewModel.watchLists.count, 1, "Watchlist has more entries than expected")
    }
}
