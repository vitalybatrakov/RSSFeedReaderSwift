//
//  URLFeedParserTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 30.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

final class URLFeedParserTests: XCTestCase {
    
    // MARK: - Properties
    
    var parser: URLFeedParser!
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        parser = URLFeedParserImpl()
    }
    
    // MARK: - Constants
    
    private enum Constants {
        static let parseFeedExpectedTimeout: Double = 5.0
    }
    
    // MARK: - Tests
    
    func testParseFeedWithURLCompletesWithError() {
        let expectation = self.expectation(description: "Parsing feeds")
        guard let url = URL(string: "https://testlink.com/test") else {
            XCTFail("invalid url")
            return
        }
        var feedResult: Result<Feed>?
        parser.parseFeed(with: url) { (result) in
            feedResult = result
            expectation.fulfill()
        }
        waitForExpectations(timeout: Constants.parseFeedExpectedTimeout, handler: nil)
        if case .error? = feedResult {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    func testParseFeedWithURLCompletesWithSuccess() {
        let expectation = self.expectation(description: "Parsing feeds")
        guard let url = URL(string: "https://habrahabr.ru/rss/interesting/") else {
            XCTFail("invalid url")
            return
        }
        var feedResult: Result<Feed>?
        parser.parseFeed(with: url) { (result) in
            feedResult = result
            expectation.fulfill()
        }
        waitForExpectations(timeout: Constants.parseFeedExpectedTimeout, handler: nil)
        if case .success? = feedResult {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
        
}
