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
    
    func getFeeds(with complition: @escaping ([Feed]) -> Void) {
        let feedURL = URL(string: "https://habrahabr.ru/rss/interesting/")!//"http://images.apple.com/main/rss/hotnews/hotnews.rss")!
        let parser = FeedParser(URL: feedURL)
        parser?.parseAsync(queue: DispatchQueue.global(qos: .default)) { (result) in
            guard let feed = result.rssFeed, result.isSuccess else {
                print(result.error as Any)
                return
            }
            DispatchQueue.main.async {
                let feedItems = feed.items?.map {
                    FeedItem(title: $0.title!, body: $0.description!, link: $0.link!)
                }
                complition([Feed(title: feed.title!, items: feedItems!)])
            }
        }
    }
}
