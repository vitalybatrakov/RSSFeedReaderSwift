//
//  FeedSourceStorageImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

final class FeedSourceStorageImpl: FeedSourceStorage {
    
    // MARK: - Properties
    
    private var storage: Storage!
    
    private let sourceListKey = "FeedSourceListKey"
    private let defaultSources = [ FeedSource(title: "Habrahabr", url: "https://habrahabr.ru/rss/interesting/"),
                                   FeedSource(title: "Swift on Medium", url: "https://medium.com/feed/tag/swift") ]
    
    // MARK: - Initilizers
    
    init(with storage: Storage) {
        self.storage = storage
    }
    
    // MARK: - Public methods
    
    func getSources() -> [FeedSource] {
        do {
            if let sources = try storage.get(objectType: [FeedSource].self, forKey: sourceListKey) {
                return sources
            }
        } catch {
            print(error.localizedDescription)
        }
        return defaultSources
    }
    
    func save(sources: [FeedSource]) {
        do {
            try storage.set(object: sources, forKey: sourceListKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func add(source: FeedSource) {
        var sources = getSources()
        sources.append(source)
        save(sources: sources)
    }
    
}
