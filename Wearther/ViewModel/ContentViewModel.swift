//
//  ContentViewModel.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

class ContentViewModel: ObservableObject {
    
    /// TNQLから取得したデータ
    @Published var tnqlData: TNQL?
    
    /// OpenWeatherから取得したデータ
    @Published var weatherData: OpenWeather?
    
    init() {
        // TNQLデコーダーを作成する（decode処理を含む）
        let tnqlDecoder = Decoder<TNQL>()
        
        // TNQLData処理後のの通知を受け取る
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureTNQLData(notification:)),
                                               name: .update,
                                               object: tnqlDecoder)
        
        // OpenWeatherデコーダーを作成する（decode処理を含む）
        let openWeatherDecoder = Decoder<OpenWeather>()
        
        // OpenWeatherData処理後のの通知を受け取る
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureOpenWeatherData(notification:)),
                                               name: .update,
                                               object: openWeatherDecoder)
        
        // TNQLにリクエストする
        TNQLRequest.request(handler: tnqlDecoder.decode(data:))
        
        // OpenWeatherにリクエストする、今回場所は東京で固定
        OpenWeatherRequest.request(place: "Tokyo", handler: openWeatherDecoder.decode(data:))
    }
    
    
    // 通知が届いたらTNQLデータをプロパティに設定する
    @objc func configureTNQLData(notification: NSNotification?) {
        if let data = notification?.userInfo?["item"] as? TNQL {
            DispatchQueue.main.async {
                self.tnqlData = data
            }
        }
    }
    
    // 通知が届いたらOpenWeatherデータをプロパティに設定する
    @objc func configureOpenWeatherData(notification: NSNotification?) {
        if let data = notification?.userInfo?["item"] as? OpenWeather {
            DispatchQueue.main.async {
                self.weatherData = data
            }
        }
    }
}
