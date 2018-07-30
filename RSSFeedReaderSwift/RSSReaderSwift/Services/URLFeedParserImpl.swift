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
    
    func parseFeed(with url: URL, complition: @escaping (Result<Feed>) -> Void) {
        guard let parser = FeedParser(URL: url) else {
            complition(.error("Init parser error on: \(url)"))
            return
        }
        parser.parseAsync(queue: DispatchQueue.global(qos: .default)) { (result) in
            guard let feed = result.rssFeed, result.isSuccess else {
                let message = result.error?.localizedDescription ?? "Unknown feed parse error"
                complition(.error(message))
                return
            }
            self.process(feed: feed, with: complition)
        }
    }
    
    private func process(feed: RSSFeed, with complition: @escaping (Result<Feed>) -> Void) {
        guard let feedTitle = feed.title,
            let feedItems = mapFeedItems(from: feed) else { return }
        let feed = Feed(title: feedTitle, items: feedItems)
        complition(.success(feed))
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
