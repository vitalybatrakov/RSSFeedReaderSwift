//
//  FeedServiceMock.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
@testable import RSSReaderSwift

class FeedServiceMock: FeedService {
    var isGetFeedsCompleted = false
    var isGetFeedsWithUrlCompleted = false
    var isNeedToSucceed = false
    var expectedFeed: Feed!
    var expectedErrorMessage: String!
    
    func getFeeds(with complition: @escaping ([Result<Feed>]) -> Void) {
        isGetFeedsCompleted = true
        complition([isNeedToSucceed ? .success(expectedFeed) : .error(expectedErrorMessage)])
    }
    
    func getFeed(with url: URL, complition: @escaping (Result<Feed>) -> Void) {
        isGetFeedsWithUrlCompleted = true
        complition(isNeedToSucceed ? .success(expectedFeed) : .error(expectedErrorMessage))
    }
    
}
