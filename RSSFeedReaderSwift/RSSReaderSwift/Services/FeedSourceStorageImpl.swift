//
//  FeedSourceStorageImpl.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

class FeedSourceStorageImpl: FeedSourceStorage {
    
    private let sourceListKey = "FeedSourceListKey"
    private let defaultSource = FeedSource(title: "Habrahabr", url: "https://habrahabr.ru/rss/interesting/")
    
    func getSources() -> [FeedSource] {
        do {
            if let sources = try UserDefaults.standard.get(objectType: [FeedSource].self, forKey: sourceListKey) {
                return sources
            }
        } catch {
            print(error.localizedDescription)
        }
        return [defaultSource]
    }
    
    func save(sources: [FeedSource]) {
        do {
            try UserDefaults.standard.set(object: sources, forKey: sourceListKey)
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
