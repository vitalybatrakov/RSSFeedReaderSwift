//
//  URLFeedParserMock.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
@testable import RSSReaderSwift

final class URLFeedParserMock: URLFeedParser {
    
    // MARK: - Propeties
    
    var isNeedToSucceed = false
    var expectedFeed: Feed!
    var expectedErrorMessage: String!
    
    // MARK: - URLFeedParser methods
    
    func parseFeed(with url: URL, completion: @escaping (Result<Feed>) -> Void) {
        completion(isNeedToSucceed ? .success(expectedFeed) : .error(expectedErrorMessage))
    }
    
}
