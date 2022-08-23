//
//  FeedServiceMock.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
@testable import RSSReaderSwift

final class FeedServiceMock: FeedService {
    
    // MARK: - Properties
    
    var isGetFeedsCompleted = false
    var isGetFeedsWithUrlCompleted = false
    var isNeedToSucceed = false
    var expectedFeed: Feed!
    var expectedErrorMessage: String!
    
    // MARK: - Errors
    
    enum FeedServiceMockError: Error {
        case error
    }
    
    // MARK: - FeedService methods

    func getFeeds() async -> [Result<Feed, Error>] {
        isGetFeedsCompleted = true
        return [isNeedToSucceed ? .success(expectedFeed) : .failure(FeedServiceMockError.error)]
    }
    
    func getFeed(with url: URL) async -> Result<Feed, Error> {
        isGetFeedsWithUrlCompleted = true
        return isNeedToSucceed ? .success(expectedFeed) : .failure(FeedServiceMockError.error)
    }
}
