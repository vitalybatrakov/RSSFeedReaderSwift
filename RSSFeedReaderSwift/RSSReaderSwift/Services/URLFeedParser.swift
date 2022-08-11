//
//  URLFeedParser.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import FeedKit

final class URLFeedParser: URLFeedParserProtocol {
    
    // MARK: - Public methods
    
    func parseFeed(with url: URL, completion: @escaping (Result<Feed>) -> Void) {
        let parser = FeedParser(URL: url)
        
        parser.parseAsync(queue: DispatchQueue.global(qos: .default)) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let feed):
                guard let rssfeed = feed.rssFeed else {
                    completion(.error("Invalid rss data recieved"))
                    return
                }
                self.process(feed: rssfeed, with: completion)
                
            case .failure(let error):
                completion(.error(error.localizedDescription))
            }
        }
    }
    
    // MARK: - Private methods
    
    private func process(feed: RSSFeed, with completion: @escaping (Result<Feed>) -> Void) {
        guard
            let feedTitle = feed.title,
            let feedItems = mapFeedItems(from: feed)
        else {
            return
        }
        let feed = Feed(title: feedTitle, items: feedItems)
        completion(.success(feed))
    }
    
    private func mapFeedItems(from feed: RSSFeed) -> [FeedItem]? {
        return feed.items?.compactMap({ (item) -> FeedItem? in
            guard
                let title = item.title,
                let description = item.description,
                let link = item.link
            else {
                return nil
            }
            return FeedItem(title: title, body: description, link: link)
        })
    }
    
}
