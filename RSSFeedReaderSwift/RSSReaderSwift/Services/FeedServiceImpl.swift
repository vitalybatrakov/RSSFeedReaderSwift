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
    
    private var feedSourceStorage: FeedSourceStorage!
    
    init(with feedSourceStorage: FeedSourceStorage) {
        self.feedSourceStorage = feedSourceStorage
    }
    
    func getFeeds(with complition: @escaping ([Result<Feed>]) -> Void) {
        let sources = feedSourceStorage.getSources()
        var results = [Result<Feed>]()
        let dispatchGroup = DispatchGroup()
        for source in sources {
            dispatchGroup.enter()
            guard let url = URL(string: source.url) else { continue }
            getFeed(with: url) { result in
                results.append(result)
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            complition(results)
        }
    }
    
    func getFeed(with url: URL, complition: @escaping (Result<Feed>) -> Void) {
        guard let parser = FeedParser(URL: url) else {
            complition(.error("Invalid url"))
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
