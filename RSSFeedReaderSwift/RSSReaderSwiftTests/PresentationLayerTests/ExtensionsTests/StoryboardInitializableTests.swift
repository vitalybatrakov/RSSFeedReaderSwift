//
//  StoryboardInitializableTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 24.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class StoryboardInitializableTests: XCTestCase {
    
    class TestViewController: UIViewController, StoryboardInitializable {}
    
    func testStoryboardIdentifierIsCorrect() {
        XCTAssertEqual(TestViewController.storyboardIdentifier, "TestViewController")
    }
    
}
