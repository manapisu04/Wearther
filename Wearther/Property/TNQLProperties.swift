//
//  TNQLProperties.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

/// TNQL用のプロパティを読み込む
class TNQLProperties {
    private let properties: [String : Any]
    
    /// TNQLのプロパティ
    static let shared = TNQLProperties()
    
    private init() {
        let path = Bundle.main.path(forResource: "TNQL", ofType: "plist")
        let dictionary = NSDictionary(contentsOfFile: path!)
        if let properties = dictionary as? [String : Any] {
            self.properties = properties
        } else {
            self.properties = [:]
        }
    }

    func value(of key: String) -> String? {
        return self.properties[key] as? String
    }
}

