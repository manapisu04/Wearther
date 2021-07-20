//
//  OpenWeatherProperties.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

/// OpenWeather用のプロパティを読み込む
class OpenWeatherProperties {
    private let properties: [String : Any]
    
    /// OpenWeatherのプロパティ
    static let shared = OpenWeatherProperties()
    
    private init() {
        let path = Bundle.main.path(forResource: "OpenWeather", ofType: "plist")
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
