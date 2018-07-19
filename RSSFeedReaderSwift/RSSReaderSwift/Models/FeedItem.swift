//
//  FeedItem.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

struct FeedItem {
    let title: String
    let body: String
    let link: String
    var imageUrl: String?
    
    init(title: String, body: String, link: String) {
        self.title = title
        self.body = body.withoutHtmlTags
        self.link = link
        self.imageUrl = imageUrl(from: body)
    }
    
    private func imageUrl(from description: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?", options: .caseInsensitive)
            let result = regex.firstMatch(in: description, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, description.count))
            return result.map {
                String(description[Range($0.range(at: 2), in: description)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
}
