//
//  Bool+Toggle.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 18.08.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

extension Bool {
    
    mutating func toggle() {
        self = !self
    }
    
}
