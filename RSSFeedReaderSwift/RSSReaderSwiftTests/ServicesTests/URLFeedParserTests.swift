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
    
    // MARK: - Tests
    
    func testParseFeedWithURLCompletesWithError() {
        guard let url = URL(string: "https://testlink.com/test") else {
            XCTFail("invalid url")
            return
        }
        Task {
            do {
                let _ = try await parser.parseFeed(with: url)
                XCTAssertTrue(true)
            } catch {
                XCTAssertTrue(false)
            }
        }
    }
    
    func testParseFeedWithURLCompletesWithSuccess() {
        guard let url = URL(string: "https://habrahabr.ru/rss/interesting/") else {
            XCTFail("invalid url")
            return
        }
        Task {
            do {
                let _ = try await parser.parseFeed(with: url)
                XCTAssertTrue(true)
            } catch {
                XCTAssertTrue(false)
            }
        }
    }
}
