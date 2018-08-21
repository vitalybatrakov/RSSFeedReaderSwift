//
//  FeedItemTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class FeedItemTests: XCTestCase {
    
    var feedItem: FeedItem!
    
    let bodyForTest = "Description with <tag>"
    let expectedTitle = "Title"
    let expectedBody = "Description with"
    let expectedLink = "https://testlink.com/test"
    let expectedEmptyImageUrl: String? = nil
    
    override func setUp() {
        super.setUp()
        feedItem = FeedItem(title: expectedTitle, body: bodyForTest, link: expectedLink)
    }
    
    // MARK: - Initializing tests
    
    func testInitTitle() {
        XCTAssertEqual(feedItem.title, expectedTitle)
    }
    
    func testInitBody() {
        XCTAssertEqual(feedItem.body, expectedBody)
    }
    
    func testInitLink() {
        XCTAssertEqual(feedItem.link, expectedLink)
    }
    
    func testInitImageRegex() {
        XCTAssertNotNil(FeedItem.imageRegex)
    }
    
    // MARK: - Initializing image url property tests

    func testInitImageUrlWithoutImageInBody() {
        XCTAssertEqual(feedItem.imageUrl, expectedEmptyImageUrl)
    }
    
    func testInitImageUrlWithImageInBody() {
        let expectedImageUrl = "https://testlink.com/test/test.jpg"
        let expectedBodyWithImageUrl = "Description with <img src=\"\(expectedImageUrl)\">"
        let feedItem = FeedItem(title: expectedTitle, body: expectedBodyWithImageUrl, link: expectedLink)
        XCTAssertEqual(feedItem.imageUrl, expectedImageUrl)
    }
    
}
