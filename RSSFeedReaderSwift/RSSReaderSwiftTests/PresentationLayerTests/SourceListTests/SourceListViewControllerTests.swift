//
//  SourceListViewControllerTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class SourceListViewControllerTests: XCTestCase {
    
    var sut: SourceListTableViewController!
    var feedSourceStorageMock: FeedSourceStorageMock!
    
    var onBackActionCalled = false
    var expectedFeedSources = [FeedSource]()
    let expectedFeedSource = FeedSource(title: "Test title", url: "test url")
    let expectedSecondFeedSource = FeedSource(title: "Second title ", url: "Second url")
    
    override func setUp() {
        super.setUp()
        expectedFeedSources.append(expectedFeedSource)
        expectedFeedSources.append(expectedSecondFeedSource)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SourceListTableViewControllerID") as! SourceListTableViewController
        setUpMocks(for: sut)
        sut.loadViewIfNeeded()
    }
    
    private func setUpMocks(for sut: SourceListTableViewController) {
        feedSourceStorageMock = FeedSourceStorageMock()
        feedSourceStorageMock.expectedFeedSources = expectedFeedSources
        sut.feedSourceStorage = feedSourceStorageMock
        sut.onBackAction = { [weak self] in
            self?.onBackActionCalled = true
        }
    }
    
    func testViewDidLoadSources() {
        XCTAssertTrue(feedSourceStorageMock.getSourcesCalled)
    }
    
    func testEditButtonTapped() {
        let isEditingBefore = sut.tableView.isEditing
        sut.editButtonTapped(sut.editButtonItem)
        let isEditingAfter = sut.tableView.isEditing
        XCTAssertTrue(isEditingBefore == !isEditingAfter)
    }
    
    func testBackAction() {
        sut.willMove(toParentViewController: nil)
        XCTAssertTrue(onBackActionCalled)
    }
    
    // MARK: TableView dataSource tests
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testNumberOfSections() {
        let sectionCount = sut.numberOfSections(in: sut.tableView)
        XCTAssertEqual(sectionCount, 1)
    }
    
    func testNumberOfRows() {
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 2)
    }
    
    func testCellHaveCorrectLabels() {
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        XCTAssertEqual(cell.textLabel?.text, expectedFeedSource.title)
        XCTAssertEqual(cell.detailTextLabel?.text, expectedFeedSource.url)
    }
    
    func testRemoveRow() {
        sut.tableView(sut.tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        feedSourceStorageMock.expectedFeedSources.append(expectedFeedSources.first!)
        XCTAssertEqual(rowCount, 1)
    }
    
    func testMoveRow() {
        let fromIndex = IndexPath(row: 0, section: 0)
        let toIndex = IndexPath(row: 1, section: 0)
        let fromCellBefore = sut.tableView(sut.tableView, cellForRowAt: fromIndex)
        let toCellBefore = sut.tableView(sut.tableView, cellForRowAt: toIndex)
        sut.tableView(sut.tableView, moveRowAt: fromIndex, to: toIndex)
        let fromCellAfter = sut.tableView(sut.tableView, cellForRowAt: fromIndex)
        let toCellAfter = sut.tableView(sut.tableView, cellForRowAt: toIndex)
        XCTAssertEqual(fromCellBefore.textLabel?.text, toCellAfter.textLabel?.text)
        XCTAssertEqual(toCellBefore.textLabel?.text, fromCellAfter.textLabel?.text)
    }
    
    // MARK: Cell init tests
    
    func testCellInit() {
        let cell = sut.tableView.dequeueReusableCell(withIdentifier: "SourceListTableViewCellId")
        XCTAssertNotNil(cell?.textLabel)
        XCTAssertNotNil(cell?.detailTextLabel)
    }
    
    // MARK: Navigation tests
    
    func testHasSegueToFeedItemDetailsViewController() {
        XCTAssertTrue(sut.hasSegueWithIdentifier(id: "AddSourceSegue"))
    }
    
}