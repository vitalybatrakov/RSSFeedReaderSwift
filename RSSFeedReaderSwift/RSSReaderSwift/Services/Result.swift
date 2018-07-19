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
