//
//  FeedSourceStorageTests.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 30.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import XCTest
@testable import RSSReaderSwift

class FeedSourceStorageTests: XCTestCase {
    
    func testGetSources() {
        let feedSourceStorage = FeedSourceStorageImpl(with: UserDefaultsMock())
        let sources = feedSourceStorage.getSources()
        XCTAssertEqual(sources.count, 2, "Initial sources is not default")
    }
    
    func testSaveSources() {
        let feedSourceStorage = FeedSourceStorageImpl(with: UserDefaultsMock())
        feedSourceStorage.save(sources: [FeedSource(title: "test", url: "test url")])
        let sources = feedSourceStorage.getSources()
        XCTAssertEqual(sources.count, 1)
    }

    func testAddSource() {
        let feedSourceStorage = FeedSourceStorageImpl(with: UserDefaultsMock())
        let oldSources = feedSourceStorage.getSources()
        feedSourceStorage.add(source: FeedSource(title: "test", url: "test url"))
        let newSources = feedSourceStorage.getSources()
        XCTAssertEqual(oldSources.count + 1, newSources.count)
    }
    
}
