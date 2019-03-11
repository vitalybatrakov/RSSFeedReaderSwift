//
//  FeedServiceTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

final class FeedServiceTests: XCTestCase {
    
    // MARK: - Properties
    
    var feedService: FeedService!
    var feedParserMock: URLFeedParserMock!
    
    let expectedFeed = Feed(title: "Test Feed", items: [FeedItem]())
    let expectedFeedSources = [FeedSource(title: "Habrahabr", url: "https://habrahabr.ru/rss/interesting/"),
                               FeedSource(title: "Swift on Medium", url: "https://medium.com/feed/tag/swift")]
    let expectedErrorMessage = "TestError"
    let testUrl = URL(string: "https://testlink.com/test")!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        feedParserMock = URLFeedParserMock()
        feedParserMock.expectedFeed = expectedFeed
        feedParserMock.expectedErrorMessage = expectedErrorMessage
        let sourceStorageMock = FeedSourceStorageMock()
        sourceStorageMock.expectedFeedSources = expectedFeedSources
        feedService = FeedServiceImpl(with: sourceStorageMock, feedParser: feedParserMock)
    }
    
    // MARK: - Tests
    
    private enum Constants {
        static let getFeedExpectedTimeout: Double = 5.0
    }
    
    func testGetFeedsWithSourcesFromStorage() {
        let expectation = self.expectation(description: "Getting feeds")
        var feedResults: [Result<Feed>]?
        feedService.getFeeds { (results) in
            feedResults = results
            expectation.fulfill()
        }
        waitForExpectations(timeout: Constants.getFeedExpectedTimeout, handler: nil)
        XCTAssertEqual(feedResults?.count, expectedFeedSources.count)
    }
    
    func testGetFeedCompletesWithSuccess() {
        feedParserMock.isNeedToSucceed = true
        var feedResult: Result<Feed>?
        feedService.getFeed(with: testUrl) { (result) in
            feedResult = result
        }
        XCTAssertEqual(feedResult, .success(expectedFeed))
    }
    
    func testGetFeedCompletesWithError() {
        var feedResult: Result<Feed>?
        feedService.getFeed(with: testUrl) { (result) in
            feedResult = result
        }
        XCTAssertEqual(feedResult, .error(expectedErrorMessage))
    }

}
