//
//  ResultTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 30.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class ResultTests: XCTestCase {

    func testSuccessEqualityIsTrue() {
        let sut = Result.success(Feed(title: "Test", items: []))
        let other = Result.success(Feed(title: "Test", items: []))
        XCTAssertEqual(sut, other)
        XCTAssertEqual(other, sut)
    }
    
    func testSuccessEqualityIsFalse() {
        let sut = Result.success(Feed(title: "Test", items: []))
        let other = Result.success(Feed(title: "", items: []))
        XCTAssertNotEqual(sut, other)
        XCTAssertNotEqual(other, sut)
    }
    
    func testErrorEqualityIsTrue() {
        let sut = Result<Feed>.error("Test")
        let other = Result<Feed>.error("Test")
        XCTAssertEqual(sut, other)
        XCTAssertEqual(other, sut)
    }
    
    func testErrorEqualityIsFalse() {
        let sut = Result<Feed>.error("Test")
        let other = Result<Feed>.error("")
        XCTAssertNotEqual(sut, other)
        XCTAssertNotEqual(other, sut)
    }
    
}
