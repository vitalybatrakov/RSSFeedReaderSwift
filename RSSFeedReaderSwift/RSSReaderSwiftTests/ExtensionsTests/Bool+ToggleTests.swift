//
//  Bool+ToggleTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 18.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class BoolToggleTests: XCTestCase {

    func testToggleFalse() {
        var sut = false
        sut.toggle()
        XCTAssertTrue(sut)
    }
    
    func testToggleTrue() {
        var sut = true
        sut.toggle()
        XCTAssertFalse(sut)
    }

}
