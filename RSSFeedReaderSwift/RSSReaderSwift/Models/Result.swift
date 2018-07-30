//
//  Result.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 19.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

enum Result<T> {
    case success(T)
    case error(String)
}

extension Result: Equatable where T: Equatable {

    static func == (lhs: Result<T>, rhs: Result<T>) -> Bool {
        switch (lhs, rhs) {
        case let (.success(l), .success(r)): return l == r
        case let (.error(l), .error(r)): return l == r
        default: return false
        }
    }
}
