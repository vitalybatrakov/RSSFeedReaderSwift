//
//  StringWithoutHTMLTagsTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest

class StringWithoutHTMLTagsTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testEmpty() {
        let string = "".withoutHTMLTags
        XCTAssertTrue(string.isEmpty)
    }
    
    func testWithoutTags() {
        let expectedString = "Test string"
        let string = expectedString.withoutHTMLTags
        XCTAssertEqual(string, expectedString)
    }
    
    func testWithTags() {
        let stringOnTest = "<p>&nbsp;&nbsp;test result</p><br/>"
        let expectedString = "test result"
        let string = stringOnTest.withoutHTMLTags
        XCTAssertEqual(string, expectedString)
    }
}
