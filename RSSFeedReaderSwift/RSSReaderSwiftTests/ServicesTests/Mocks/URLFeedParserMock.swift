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
    
    // MARK: - Errors
    
    enum MockedParserError: Error {
        case invalidFeed
    }
    
    // MARK: - URLFeedParser methods
    
    func parseFeed(with url: URL) async throws -> Feed {
        if isNeedToSucceed {
            return expectedFeed
        } else {
            throw MockedParserError.invalidFeed
        }
    }
}
