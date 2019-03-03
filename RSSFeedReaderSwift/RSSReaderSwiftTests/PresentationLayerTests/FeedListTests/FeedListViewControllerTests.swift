//
//  FeedListViewControllerTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

final class FeedListViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: FeedListViewController!
    
    // MARK: - Properties
    
    var feedServiceMock: FeedServiceMock!
    
    var expectedFeed: Feed!
    let expectedFeedSources = [FeedSource(title: "Habrahabr",
                                          url: "https://habrahabr.ru/rss/interesting/"),
                               FeedSource(title: "Swift on Medium",
                                          url: "https://medium.com/feed/tag/swift")]
    let expectedFeedItem = FeedItem(title: "Test item title",
                                    body: "Test body",
                                    link: "Test link")
    
    // MARK: - Setup methods

    override func setUp() {
        super.setUp()
        expectedFeed = Feed(title: "Test title", items: [expectedFeedItem])
        sut = FeedListViewController.initFromStoryboard()
        setUpMocks(for: sut)
        sut.loadViewIfNeeded()
    }
    
    private func setUpMocks(for sut: FeedListViewController) {
        feedServiceMock = FeedServiceMock()
        feedServiceMock.expectedFeed = expectedFeed
        feedServiceMock.isNeedToSucceed = true
        feedServiceMock.expectedErrorMessage = "TestError" 
        let feedSourceStorage = FeedSourceStorageMock()
        feedSourceStorage.expectedFeedSources = expectedFeedSources
        
        sut.setupServices(dependencies: (feedService: feedServiceMock,
                                         feedSourceStorage: feedSourceStorage))
    }
    
    // MARK: - Load feeds tests
    
    func testViewDidCompleted() {
        XCTAssertTrue(feedServiceMock.isGetFeedsCompleted)
    }
    
    // MARK: - TableView dataSource tests
    
    private enum Constants {
        static let testRowIndex: Int = 0
        static let testSectionIndex: Int = 0
        static let sectionsCount: Int = 1
    }
    
    func testTableViewHasDataSource() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testSectionHeaderTitles() {
        let title = sut.tableView(sut.tableView, titleForHeaderInSection: Constants.testSectionIndex)
        XCTAssertEqual(title, expectedFeed.title)
    }
    
    func testNumberOfSections() {
        let sectionCount = sut.numberOfSections(in: sut.tableView)
        XCTAssertEqual(sectionCount, Constants.sectionsCount)
    }
    
    func testNumberOfRows() {
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: Constants.testSectionIndex)
        XCTAssertEqual(rowCount, Constants.sectionsCount)
    }
    
    func testCellHaveCorrectLabels() {
        let indexPath = IndexPath(row: Constants.testRowIndex,
                                  section: Constants.testSectionIndex)
        let cell = sut.tableView(sut.tableView,
                                 cellForRowAt: indexPath) as! FeedListTableViewCell
        XCTAssertEqual(cell.titleLabel.text, expectedFeedItem.title)
        XCTAssertEqual(cell.detailsLabel.text, expectedFeedItem.body.withoutHTMLTags)
    }
    
    // MARK: - TableView delegate tests
    
    func testTableViewHasDelegate() {
        XCTAssertNotNil(sut.tableView.delegate)
    }
    
    // MARK: - Cell init tests
    
    func testCellInit() {
        let cell: FeedListTableViewCell = sut.tableView.dequeueReusableCell()
        XCTAssertNotNil(cell.titleLabel)
        XCTAssertNotNil(cell.detailsLabel)
        XCTAssertNotNil(cell.imgView)
    }

    // MARK: - Navigation tests
    
    func testHasSegueToFeedItemDetailsViewController() {
        XCTAssertTrue(sut.hasSegueWithIdentifier(id: "FeedDetailsSegue"))
    }
    
    func testHasSegueToSourceListViewController() {
        XCTAssertTrue(sut.hasSegueWithIdentifier(id: "SourceListSegue"))
    }
    
}
