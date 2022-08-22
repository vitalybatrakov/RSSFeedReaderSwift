//
//  FeedServiceImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

final class FeedServiceImpl: FeedService {
    
    // MARK: - Properties
    
    private var feedSourceStorage: FeedSourceStorage!
    private var feedParser: URLFeedParser!
    
    // MARK: - Initializers
    
    init(with feedSourceStorage: FeedSourceStorage, feedParser: URLFeedParser) {
        self.feedSourceStorage = feedSourceStorage
        self.feedParser = feedParser
    }
    
    // MARK: - Internal methods
    
    func getFeeds() async -> [Result<Feed, Error>] {
        await withTaskGroup(
            of: Result<Feed, Error>.self,
            returning: [Result<Feed, Error>].self
        ) { group in
            let sources = self.feedSourceStorage.getSources()
            let urls = sources.compactMap({ URL(string: $0.url) })
            for url in urls {
                group.addTask(priority: .medium) {
                    return await self.getFeed(with: url)
                }
            }
            
            var results = [Result<Feed, Error>]()
            
            for await result in group {
                results.append(result)
            }
            
            return results
        }
    }
    
    func getFeed(with url: URL) async -> Result<Feed, Error> {
        do {
            let feed = try await feedParser.parseFeed(with: url)
            return .success(feed)
        } catch let error {
            return .failure(error)
        }
    }
}
