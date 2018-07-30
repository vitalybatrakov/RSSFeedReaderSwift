//
//  FeedServiceTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class FeedServiceTests: XCTestCase {
    
    var feedService: FeedService!
    
    let expectedFeed = Feed(title: "Test Feed", items: [FeedItem]())
    let expectedFeedSources = [FeedSource(title: "Habrahabr", url: "https://habrahabr.ru/rss/interesting/"),
                               FeedSource(title: "Swift on Medium", url: "https://medium.com/feed/tag/swift")]
    
    class FeedSourceStorageMock: FeedSourceStorage {
        var expectedFeedSources: [FeedSource]!
        
        func getSources() -> [FeedSource] {
            return expectedFeedSources
        }
        
        func save(sources: [FeedSource]) {}
        
        func add(source: FeedSource) {}
        
    }
    
    class URLFeedParserMock: URLFeedParser {
        var expectedFeed: Feed!
        
        func parseFeed(with url: URL, complition: @escaping (Result<Feed>) -> Void) {
            complition(.success(expectedFeed))
        }

    }
    
    override func setUp() {
        super.setUp()
        let feedParserMock = URLFeedParserMock()
        feedParserMock.expectedFeed = expectedFeed
        let sourceStorageMock = FeedSourceStorageMock()
        sourceStorageMock.expectedFeedSources = expectedFeedSources
        feedService = FeedServiceImpl(with: sourceStorageMock, feedParser: feedParserMock)
    }
    
    func testGetFeedsWithSourcesFromStorage() {
        let expectation = self.expectation(description: "Getting feeds")
        var feedResults: [Result<Feed>]?
        feedService.getFeeds { (results) in
            feedResults = results
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertEqual(feedResults?.count, expectedFeedSources.count)
    }
    
    func testGetFeedWithTestUrlSuccess() {
        guard let url = URL(string: "https://testlink.com/test") else {
            XCTFail("invalid url")
            return
        }
        var feedResult: Result<Feed>?
        feedService.getFeed(with: url) { (result) in
            feedResult = result
        }
        XCTAssertEqual(feedResult, .success(expectedFeed), "Get feed with url returns invalid result")
    }

}
