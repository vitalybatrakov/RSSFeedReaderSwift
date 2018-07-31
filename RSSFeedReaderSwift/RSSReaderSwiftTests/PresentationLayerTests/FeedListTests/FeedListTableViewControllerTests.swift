//
//  FeedListTableViewControllerTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class FeedListTableViewControllerTests: XCTestCase {
    
    var sut: FeedListTableViewController!
    var feedServiceMock: FeedServiceMock!
    
    let expectedFeedSources = [FeedSource(title: "Habrahabr", url: "https://habrahabr.ru/rss/interesting/"),
                               FeedSource(title: "Swift on Medium", url: "https://medium.com/feed/tag/swift")]
    let expectedFeedItem = FeedItem(title: "Test item title", body: "Test body", link: "Test link")
    var expectedFeed: Feed!

    override func setUp() {
        super.setUp()
        expectedFeed = Feed(title: "Test title", items: [expectedFeedItem])
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "FeedListTableViewControllerID") as! FeedListTableViewController
        setUpMocks(for: sut)
        sut.loadViewIfNeeded()
    }
    
    private func setUpMocks(for sut: FeedListTableViewController) {
        feedServiceMock = FeedServiceMock()
        sut.feedService = feedServiceMock
        feedServiceMock.expectedFeed = expectedFeed
        feedServiceMock.expectedErrorMessage = "TestError"
        let feedSourceStorage = FeedSourceStorageMock()
        feedSourceStorage.expectedFeedSources = expectedFeedSources
        sut.feedSourceStorage = feedSourceStorage
    }
    
    func testViewDidLoadFeedsSuccess() {
        feedServiceMock.isNeedToSucceed = true
        sut.feedService.getFeeds(with: { (results) in
            guard let result =  results.first else {
                XCTFail("Results is empty")
                return
            }
            switch result {
            case .success(let feed):
                XCTAssertEqual(feed, self.feedServiceMock.expectedFeed)
            case .error(let error):
                XCTFail("Unexpected failure with error: \(error)")
            }
        })
    }
    
    func testViewDidLoadFeedsWithError() {
        feedServiceMock.isNeedToSucceed = false
        sut.feedService.getFeeds(with: { (results) in
            guard let result =  results.first else {
                XCTFail("Results is empty")
                return
            }
            switch result {
            case .success:
                XCTFail("Unexpected complition with success")
            case .error(let error):
                XCTAssertEqual(error, self.feedServiceMock.expectedErrorMessage)
            }
        })
    }
    
    // MARK: TableView dataSource tests
    
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

    // MARK: Navigation tests
    
    func testHasSegueToFeedItemDetailsViewController() {
        XCTAssertTrue(hasSegueWithIdentifier(id: "FeedDetailsSegue"))
    }
    
    func testHasSegueToSourceListViewController() {
        XCTAssertTrue(hasSegueWithIdentifier(id: "SourceListSegue"))
    }
    
    // utility for finding segues
    func hasSegueWithIdentifier(id: String) -> Bool {
        let segues = sut.value(forKey: "storyboardSegueTemplates") as? [NSObject]
        let filtered = segues?.filter({ $0.value(forKey: "identifier") as? String == id })
        return !(filtered?.isEmpty ?? true)
    }
    
}
