//
//  FeedItem.swift
//  RSSReaderSwift
//
//  Created by Vitaliy Batrakov on 24.04.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

struct FeedItem: Equatable {
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
    
    private func imageUrl(from body: String) -> String? {
        do {
            let regex = try NSRegularExpression(pattern: "(<img\\s[\\s\\S]*?src\\s*?=\\s*?['\"](.*?)['\"][\\s\\S]*?>)+?", options: .caseInsensitive)
            let result = regex.firstMatch(in: body, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, body.count))
            return result.map {
                String(body[Range($0.range(at: 2), in: body)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return nil
        }
    }
}
