//
//  FeedItemDetailsViewControllerTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

final class FeedItemDetailsViewControllerTests: XCTestCase {
    
    // MARK: - Subject under test
    
    var sut: FeedItemDetailsViewController!
    
    // MARK: - Properties
    
    let expectedFeedItem = FeedItem(title: "Test item title", body: "Test body", link: "Test link")
    
    // MARK: - Setup
    
    override func setUp() {
        super.setUp()
        sut = FeedItemDetailsViewController.initFromStoryboard()
        sut.feedItem = expectedFeedItem
        sut.loadViewIfNeeded()
    }
    
    // MARK: - IBOutlets tests
    
    func testTitleLabelNotNil() {
        XCTAssertNotNil(sut.titleLabel)
    }
    
    func testDescriptionLabelNotNil() {
        XCTAssertNotNil(sut.descriptionLabel)
    }
    
    func testImageViewIsNotNil() {
        XCTAssertNotNil(sut.imageView)
    }
    
    func testTitleLabelIsCorrect() {
        XCTAssertNotNil(sut.titleLabel)
        let title = sut.titleLabel.text
        XCTAssertEqual(title, expectedFeedItem.title)
    }
    
    func testDescriptionLabelIsCorrect() {
        XCTAssertNotNil(sut.descriptionLabel)
        let description = sut.descriptionLabel.text
        XCTAssertEqual(description, expectedFeedItem.body)
    }
    
    // MARK: - Navigation tests
    
    func testHasSegueToFeedItemDetailsViewController() {
        XCTAssertTrue(sut.hasSegueWithIdentifier(id: FeedItemDetailsViewController.SegueIdentifier.toWebPage.rawValue))
    }
    
}
