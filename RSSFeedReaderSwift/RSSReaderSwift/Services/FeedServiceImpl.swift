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
    
    // MARK: - Public methods
    
    func getFeeds(with completion: @escaping ([Result<Feed, Error>]) -> Void) {
        DispatchQueue.global().async {
            let sources = self.feedSourceStorage.getSources()
            var results = [Result<Feed, Error>]()
            let dispatchGroup = DispatchGroup()
            let urls = sources.compactMap({ URL(string: $0.url) })
            for url in urls {
                dispatchGroup.enter()
                self.getFeed(with: url) { result in
                    results.append(result)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                completion(results)
            }
        }
    }
    
    func getFeed(with url: URL, completion: @escaping (Result<Feed, Error>) -> Void) {
        feedParser.parseFeed(with: url, completion: completion)
    }

}
