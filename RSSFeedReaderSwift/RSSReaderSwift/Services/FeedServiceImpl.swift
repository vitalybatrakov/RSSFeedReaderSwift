//
//  FeedServiceImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import FeedKit

class FeedServiceImpl: FeedService {
    
    func getFeeds(with complition: ([Feed]) -> Void) {
        let feedURL = URL(string: "http://images.apple.com/main/rss/hotnews/hotnews.rss")!
        let parser = FeedParser(URL: feedURL)
        parser?.parseAsync(queue: DispatchQueue.global(qos: .userInitiated)) { (result) in
            guard let feed = result.rssFeed, result.isSuccess else {
                print(result.error as Any)
                return
            }
            DispatchQueue.main.async {
                print(feed)
            }
        }
    }
}
