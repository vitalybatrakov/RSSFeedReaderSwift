//
//  FeedListViewControllerTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class FeedListViewControllerTests: XCTestCase {
    
    var sut: FeedListViewController!
    var feedServiceMock: FeedServiceMock!
    var expectedFeed: Feed!
    let expectedFeedSources = [FeedSource(title: "Habrahabr", url: "https://habrahabr.ru/rss/interesting/"),
                               FeedSource(title: "Swift on Medium", url: "https://medium.com/feed/tag/swift")]
    let expectedFeedItem = FeedItem(title: "Test item title", body: "Test body", link: "Test link")

    override func setUp() {
        super.setUp()
        expectedFeed = Feed(title: "Test title", items: [expectedFeedItem])
        sut = FeedListViewController.initFromStoryboard()
        setUpMocks(for: sut)
        sut.loadViewIfNeeded()
    }
    
    private func setUpMocks(for sut: FeedListViewController) {
        feedServiceMock = FeedServiceMock()
        sut.feedService = feedServiceMock
        feedServiceMock.expectedFeed = expectedFeed
        feedServiceMock.isNeedToSucceed = true
        feedServiceMock.expectedErrorMessage = "TestError" 
        let feedSourceStorage = FeedSourceStorageMock()
        feedSourceStorage.expectedFeedSources = expectedFeedSources
        sut.feedSourceStorage = feedSourceStorage
    }
    
    func testViewDidLoadFeedsCompleted() {
        XCTAssertTrue(feedServiceMock.isGetFeedsCompleted)
    }
    
    // MARK: TableView dataSource tests
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testSectionHeaderTitles() {
        let title = sut.tableView(sut.tableView, titleForHeaderInSection: 0)
        XCTAssertEqual(title, expectedFeed.title)
    }
    
    func testNumberOfSections() {
        let sectionCount = sut.numberOfSections(in: sut.tableView)
        XCTAssertEqual(sectionCount, 1)
    }
    
    func testNumberOfRows() {
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rowCount, 1)
    }
    
    func testCellHaveCorrectLabels() {
        let cell = sut.tableView(sut.tableView, cellForRowAt: IndexPath(row: 0, section: 0)) as! FeedListTableViewCell
        XCTAssertEqual(cell.titleLabel.text, expectedFeedItem.title)
        XCTAssertEqual(cell.detailsLabel.text, expectedFeedItem.body.withoutHTMLTags)
    }
    
    // MARK: TableView delegate tests
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    // MARK: Cell init tests
    
    func testCellInit() {
        let cell: FeedListTableViewCell = sut.tableView.dequeueReusableCell()
        XCTAssertNotNil(cell.titleLabel)
        XCTAssertNotNil(cell.detailsLabel)
        XCTAssertNotNil(cell.imgView)
    }

    // MARK: Navigation tests
    
    func testHasSegueToFeedItemDetailsViewController() {
        XCTAssertTrue(sut.hasSegueWithIdentifier(id: "FeedDetailsSegue"))
    }
    
    func testHasSegueToSourceListViewController() {
        XCTAssertTrue(sut.hasSegueWithIdentifier(id: "SourceListSegue"))
    }
    
}
