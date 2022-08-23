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
        let sourceStorageMock = FeedSourceStorageMock()
        sourceStorageMock.expectedFeedSources = expectedFeedSources
        feedService = FeedServiceImpl(with: sourceStorageMock, feedParser: feedParserMock)
    }
    
    // MARK: - Tests
    
    private enum Constants {
        static let getFeedExpectedTimeout: Double = 5.0
    }
    
    func testGetFeedsWithSourcesFromStorage() {
        Task {
            let feedResults = await feedService.getFeeds()
            XCTAssertEqual(feedResults.count, expectedFeedSources.count)
        }
    }
    
    func testGetFeedCompletesWithSuccess() {
        Task {
            feedParserMock.isNeedToSucceed = true
            let feedResult = await feedService.getFeed(with: testUrl)
            switch feedResult {
            case .success(let feed):
                XCTAssertEqual(feed, expectedFeed)
                
            case .failure:
                XCTFail()
            }
        }
    }
    
    func testGetFeedCompletesWithError() {
        Task {
            let feedResult = await feedService.getFeed(with: testUrl)
            switch feedResult {
            case .success:
                XCTFail()
                
            case .failure:
                break
            }
        }
    }

}
