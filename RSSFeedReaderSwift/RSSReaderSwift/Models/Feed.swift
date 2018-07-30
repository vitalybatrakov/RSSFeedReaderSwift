//
//  Feed.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

struct Feed: Equatable {
    let title: String
    let items: [FeedItem]
}
