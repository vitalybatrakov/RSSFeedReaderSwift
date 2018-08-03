//
//  AddSourceViewControllerTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class AddSourceViewControllerTests: XCTestCase {
    
    var sut: AddSourceViewController!
    var feedServiceMock: FeedServiceMock!
    var feedSourceStorageMock: FeedSourceStorageMock!
    
    var onAddNewSourceCalled = false
    var expectedFeed = Feed(title: "Test title", items: [])
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "AddSourceViewControllerID") as! AddSourceViewController
        setUpMocks(for: sut)
        sut.loadViewIfNeeded()
    }
    
    private func setUpMocks(for sut: AddSourceViewController) {
        feedServiceMock = FeedServiceMock()
        sut.feedService = feedServiceMock
        feedServiceMock.expectedFeed = expectedFeed
        feedServiceMock.isNeedToSucceed = true
        feedServiceMock.expectedErrorMessage = "TestError"
        feedSourceStorageMock = FeedSourceStorageMock()
        sut.feedSourceStorage = feedSourceStorageMock
    }
    
    func testInitSourceTextField() {
        XCTAssertNotNil(sut.sourceTextField)
    }
    
    func testInitProgressIndicator() {
        XCTAssertNotNil(sut.progessIndicator)
    }
    
    func testAddButtonTappedCompletesWithSuccess() {
        let expectation = self.expectation(description: "Adding source with success")
        sut.onAddNewSource = { [weak self] in
            self?.onAddNewSourceCalled = true
            expectation.fulfill()
        }
        sut.sourceTextField.text = "https://medium.com/feed/tag/swift"
        sut.addButtonTapped(sut)
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(feedServiceMock.isGetFeedsWithUrlCompleted)
        XCTAssertTrue(feedSourceStorageMock.addSourceCalled)
        XCTAssertTrue(onAddNewSourceCalled)
    }
    
    func testAddButtonTappedCompletesWithError() {
        feedServiceMock.isNeedToSucceed = false
        let expectation = self.expectation(description: "Adding source with error")
        sut.sourceTextField.text = "https://test.com"
        sut.addButtonTapped(sut)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: 1.5, handler: nil)
        XCTAssertTrue(feedServiceMock.isGetFeedsWithUrlCompleted)
        XCTAssertFalse(sut.progessIndicator.isAnimating)
    }

}
