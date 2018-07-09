//
//  FeedService.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 23.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

protocol FeedService {
    func getFeeds(with complition: @escaping ([Feed]) -> Void)
}
