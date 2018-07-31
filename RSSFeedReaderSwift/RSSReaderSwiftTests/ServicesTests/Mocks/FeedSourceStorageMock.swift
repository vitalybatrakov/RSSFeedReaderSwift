//
//  FeedSourceStorageMock.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
@testable import RSSReaderSwift

class FeedSourceStorageMock: FeedSourceStorage {
    var expectedFeedSources: [FeedSource]!
    
    func getSources() -> [FeedSource] {
        return expectedFeedSources
    }
    
    func save(sources: [FeedSource]) {}
    
    func add(source: FeedSource) {}
    
}
