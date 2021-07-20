//
//  OpenWeather.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

/// OpenWeatherを受け取る構造体
struct OpenWeather: Decodable {
    /// 天候、天気アイコンを受け取る
    let weather: [Weather]
    
    /// 地域
    let name: String
    
    /// 気温・湿度を受けとる
    let main: MainWeather
}

/// 気温・湿度を受けとる構造体
struct MainWeather: Decodable {
    /// 気温
    let temp: Double
    /// 湿度
    let humidity: Double
}

/// 天候を受け取る構造体
struct Weather: Decodable {
    /// 天候
    let description: String
    /// 天気アイコン
    let icon: String
}
