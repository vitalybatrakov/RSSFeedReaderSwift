//
//  UserDefaultsExtension.swift
//  RSSReaderSwift
//
//  Created by Vitaly Batrakov on 16.07.2018.
//  Copyright © 2018 vbat. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    public func set<T: Codable>(object: T, forKey: String) throws {
        let jsonData = try JSONEncoder().encode(object)
        set(jsonData, forKey: forKey)
    }
    
    public func get<T: Codable>(objectType: T.Type, forKey: String) throws -> T? {
        guard let result = value(forKey: forKey) as? Data else {
            return nil
        }
        return try JSONDecoder().decode(objectType, from: result)
    }
}
