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
        let feedURL = URL(string: "https://habrahabr.ru/rss/interesting/")!
        let parser = FeedParser(URL: feedURL)
        parser?.parseAsync(queue: DispatchQueue.global(qos: .default)) { (result) in
            guard let feed = result.rssFeed, result.isSuccess else {
                print(result.error as Any)
                return
            }
            self.process(feed: feed, with: complition)
        }
    }
    
    private func process(feed: RSSFeed, with complition: @escaping ([Feed]) -> Void) {
        DispatchQueue.main.async {
            guard let feedTitle = feed.title,
                  let feedItems = self.mapFeedItems(from: feed) else { return }
            complition([Feed(title: feedTitle, items: feedItems)])
        }
    }
    
    private func mapFeedItems(from feed: RSSFeed) -> [FeedItem]? {
        return feed.items?.compactMap({ (item) -> FeedItem? in
            guard let title = item.title,
                let description = item.description,
                let link = item.link else { return nil }
            
            return FeedItem(title: title, body: description, link: link)
        })
    }
}
