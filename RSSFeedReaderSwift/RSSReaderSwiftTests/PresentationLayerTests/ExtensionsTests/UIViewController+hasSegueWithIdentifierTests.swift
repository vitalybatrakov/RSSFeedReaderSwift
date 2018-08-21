//
//  UIViewController+hasSegueWithIdentifierTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 18.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class UIViewControllerHasSegueWithIdentifierTests: XCTestCase {

    func testHasSegueOnControllerWithNoSegues() {
        let sut = UIViewController()
        let hasSegue = sut.hasSegueWithIdentifier(id: "TestSegueId")
        XCTAssertFalse(hasSegue)
    }
    
    func testHasAddedSegueOnViewController() {
        let sut = UIViewController()
        let newSegue = UIStoryboardSegue(identifier: "TestSegueId", source: sut, destination: sut)
        sut.setValue([newSegue], forKey: "storyboardSegueTemplates")
        let hasSegue = sut.hasSegueWithIdentifier(id: "TestSegueId")
        XCTAssertTrue(hasSegue)
    }
    
}
