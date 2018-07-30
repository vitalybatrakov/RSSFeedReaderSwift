//
//  URLFeedParserTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 30.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class URLFeedParserTests: XCTestCase {
    
    var parser: URLFeedParser!
    
    override func setUp() {
        super.setUp()
        parser = URLFeedParserImpl()
    }
    
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
        waitForExpectations(timeout: 5, handler: nil)
        guard case .error? = feedResult else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertTrue(true)
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
        waitForExpectations(timeout: 5, handler: nil)
        guard case .success? = feedResult else {
            XCTAssertTrue(false)
            return
        }
        XCTAssertTrue(true)
    }
        
}
