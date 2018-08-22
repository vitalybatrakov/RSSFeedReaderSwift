//
//  URLFeedParserImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import FeedKit

class URLFeedParserImpl: URLFeedParser {
    
    func parseFeed(with url: URL, completion: @escaping (Result<Feed>) -> Void) {
        let parser = FeedParser(URL: url)
        parser.parseAsync(queue: DispatchQueue.global(qos: .default)) { (result) in
            guard let feed = result.rssFeed, result.isSuccess else {
                let message = result.error?.localizedDescription ?? "Unknown feed parse error"
                completion(.error(message))
                return
            }
            self.process(feed: feed, with: completion)
        }
    }
    
    private func process(feed: RSSFeed, with completion: @escaping (Result<Feed>) -> Void) {
        guard let feedTitle = feed.title,
            let feedItems = mapFeedItems(from: feed) else { return }
        let feed = Feed(title: feedTitle, items: feedItems)
        completion(.success(feed))
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
