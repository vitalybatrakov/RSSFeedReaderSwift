//
//  URLFeedParserImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 27.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation
import FeedKit

enum URLFeedParseError: Error {
    case invalidFeed
}

final class URLFeedParserImpl: URLFeedParser {
    
    // MARK: - Internal methods
    
    func parseFeed(with url: URL) async throws -> Feed {
        try await withCheckedThrowingContinuation { continuation in
            let parser = FeedParser(URL: url)
            parser.parseAsync(queue: DispatchQueue.global(qos: .default)) { [weak self] result in
                guard let self = self else { return }
                
                switch result {
                case .success(let feed):
                    guard
                        let rssFeed = feed.rssFeed,
                        let feedTitle = rssFeed.title,
                        let feedItems = self.mapFeedItems(from: rssFeed)
                    else {
                        continuation.resume(with: .failure(URLFeedParseError.invalidFeed))
                        return
                    }
                    let feed = Feed(title: feedTitle, items: feedItems)
                    continuation.resume(with: .success(feed))
                    
                case .failure(let error):
                    continuation.resume(with: .failure(error))
                }
            }
        }
    }
    
    // MARK: - Private methods
    
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
