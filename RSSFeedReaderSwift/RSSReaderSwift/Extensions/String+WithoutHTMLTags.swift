//
//  String+WithoutHTMLTags.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 19.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

extension String {
    
    public var withoutHTMLTags: String {
        return self.replacingOccurrences(of: "<[^>]+>|&[^;]+;",
                                         with: "",
                                         options: .regularExpression,
                                         range: nil)
            .trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
