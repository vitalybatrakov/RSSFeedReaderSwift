//
//  FeedServiceImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

class FeedServiceImpl: FeedService {
    
    private var feedSourceStorage: FeedSourceStorage!
    private var feedParser: URLFeedParser!
    
    init(with feedSourceStorage: FeedSourceStorage, feedParser: URLFeedParser) {
        self.feedSourceStorage = feedSourceStorage
        self.feedParser = feedParser
    }
    
    func getFeeds(with complition: @escaping ([Result<Feed>]) -> Void) {
        DispatchQueue.global().async {
            let sources = self.feedSourceStorage.getSources()
            var results = [Result<Feed>]()
            let dispatchGroup = DispatchGroup()
            for source in sources {
                dispatchGroup.enter()
                guard let url = URL(string: source.url) else { continue }
                self.getFeed(with: url) { result in
                    results.append(result)
                    dispatchGroup.leave()
                }
            }
            dispatchGroup.notify(queue: .main) {
                complition(results)
            }
        }
    }
    
    func getFeed(with url: URL, complition: @escaping (Result<Feed>) -> Void) {
        feedParser.parseFeed(with: url, complition: complition)
    }

}
