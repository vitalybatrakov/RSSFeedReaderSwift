//
//  RSSFeedParser.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import FeedKit

protocol URLFeedParserProtocol {
    
    func parseFeed(with url: URL, completion: @escaping (Result<Feed>) -> Void)
    
}

