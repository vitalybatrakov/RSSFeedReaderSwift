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
    
    // MARK: - Subject under test
    
    var sut: AddSourceViewController!
    
    // MARK: - Mocks
    
    var feedServiceMock: FeedServiceMock!
    var feedSourceStorageMock: FeedSourceStorageMock!
    
    // MARK: - Properties
    
    var onAddNewSourceCalled = false
    var expectedFeed = Feed(title: "Test title", items: [])
    
    // MARK: - Setup methods
    
    override func setUp() {
        super.setUp()
        sut = AddSourceViewController.initFromStoryboard()
        setupMocks(for: sut)
        sut.loadViewIfNeeded()
    }
    
    private func setupMocks(for sut: AddSourceViewController) {
        feedServiceMock = FeedServiceMock()
        feedServiceMock.expectedFeed = expectedFeed
        feedServiceMock.isNeedToSucceed = true
        feedServiceMock.expectedErrorMessage = "TestError"
        
        feedSourceStorageMock = FeedSourceStorageMock()
        
        sut.setup(dependencies: (feedService: feedServiceMock,
                                 feedSourceStorage: feedSourceStorageMock,
                                 onAddNewSource: {}))
    }
    
    // MARK: - IBOutlets tests
    
    func testInitSourceTextField() {
        XCTAssertNotNil(sut.sourceTextField)
    }
    
    func testInitProgressIndicator() {
        XCTAssertNotNil(sut.progessIndicator)
    }
    
    func testProgressIndicatorIsNotAnimatingBeforeAdding() {
        XCTAssertFalse(sut.progessIndicator.isAnimating)
    }
    
    // MARK: - Actions tests
    
    private enum Constants {
        static let addNewSourceDelay: Double = 1.0
        static let addNewSourceWaitDelay: Double = 3.0
    }
    
    func addNewSourceWithSuccess() {
        let expectation = self.expectation(description: "Adding source with success")
        let onAddNewSource = { [weak self] in
            self?.onAddNewSourceCalled = true
            expectation.fulfill()
        }
        sut.setup(dependencies: (feedService: feedServiceMock,
                                 feedSourceStorage: feedSourceStorageMock,
                                 onAddNewSource: onAddNewSource))
        
        sut.sourceTextField.text = "https://medium.com/feed/tag/swift"
        sut.addButtonTapped(sut)
        waitForExpectations(timeout: Constants.addNewSourceDelay, handler: nil)
    }
    
    func testGetFeedsCompletesOnAddButtonTapped() {
        addNewSourceWithSuccess()
        XCTAssertTrue(feedServiceMock.isGetFeedsWithUrlCompleted)
    }
    
    func testAddSourceCalledOnAddButtonTapped() {
        addNewSourceWithSuccess()
        XCTAssertTrue(feedSourceStorageMock.addSourceCalled)
    }
    
    func testOnAddSourceBloackCallesOnAddButtonTapped() {
        addNewSourceWithSuccess()
        XCTAssertTrue(onAddNewSourceCalled)
    }
    
    func testGetFeedsCompletesWithErrorOnAddButtonTapped() {
        addNewSourceWithError()
        print(feedServiceMock.isGetFeedsWithUrlCompleted)
        XCTAssertTrue(feedServiceMock.isGetFeedsWithUrlCompleted)
    }
    
    func testProgressIndicatorNotAnimatingAfterAddNewSourceCompletesWithError() {
        addNewSourceWithError()
        XCTAssertFalse(sut.progessIndicator.isAnimating)
    }
    
    func addNewSourceWithError() {
        feedServiceMock.isNeedToSucceed = false
        let expectation = self.expectation(description: "Adding source with error")
        sut.sourceTextField.text = "https://test.com"
        sut.addButtonTapped(sut)
        DispatchQueue.main.asyncAfter(deadline: .now() + Constants.addNewSourceDelay, execute: {
            expectation.fulfill()
        })
        waitForExpectations(timeout: Constants.addNewSourceWaitDelay, handler: nil)
    }
    

}
