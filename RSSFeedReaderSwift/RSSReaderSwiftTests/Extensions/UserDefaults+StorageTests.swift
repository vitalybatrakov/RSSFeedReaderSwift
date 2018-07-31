//
//  UserDefaults+StorageTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class UserDefaultsStorageTests: XCTestCase {
    
    let testKey = "TestKey"
    let expectedFeedSource = FeedSource(title: "Test title", url: "Test url")
    
    func testGetFeedObject() {
        let userDefaults = UserDefaultsMock()
        do {
            if let feedSource = try userDefaults.get(objectType: FeedSource.self, forKey: testKey) {
                XCTAssertNil(feedSource)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }

    func testSetFeedObject() {
        let userDefaults = UserDefaultsMock()
        do {
            try userDefaults.set(object: expectedFeedSource, forKey: testKey)
        } catch {
            XCTFail(error.localizedDescription)
        }
        do {
            if let feedSource = try userDefaults.get(objectType: FeedSource.self, forKey: testKey) {
                XCTAssertEqual(feedSource.title, expectedFeedSource.title)
            }
        } catch {
            XCTFail(error.localizedDescription)
        }
    }
    
}
