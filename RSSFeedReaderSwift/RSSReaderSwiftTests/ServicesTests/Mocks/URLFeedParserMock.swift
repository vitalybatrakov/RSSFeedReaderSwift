//
//  URLFeedParserMock.swift
//  RSSReaderSwiftTests
//
//  Created by Vitaly Batrakov on 31.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
@testable import RSSReaderSwift

class URLFeedParserMock: URLFeedParser {
    var expectedFeed: Feed!
    
    func parseFeed(with url: URL, complition: @escaping (Result<Feed>) -> Void) {
        complition(.success(expectedFeed))
    }
    
}
