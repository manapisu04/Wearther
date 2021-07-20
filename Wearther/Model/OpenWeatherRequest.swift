//
//  OpenWeatherRequest.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

class OpenWeatherRequest{

    
    static func request(place: String, handler: ((Data) -> ())? = nil) {

        guard let domain = OpenWeatherProperties.shared.value(of: "OpenWeather_Domain"),
              let endPoint = OpenWeatherProperties.shared.value(of: "OpenWeather_EndPoint"),
              let appID = OpenWeatherProperties.shared.value(of: "OpenWeather_AppID") else {
            return
        }
        
        guard let url = URL(string: domain + endPoint) else { return }
        
        // urlが解決できているので強制アンラップする
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "appid", value: appID),
                                 // 場所は引数で受け取るが、今回は東京で固定
                                 URLQueryItem(name: "q", value: place),
                                 URLQueryItem(name: "lang", value: "ja"),
                                 URLQueryItem(name: "units", value: "metric")]
        print(components.url!)
        
        // リクエストを作成する
        var request = URLRequest(url: components.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        

        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            
            // セッションの終了
            session.finishTasksAndInvalidate()

            // エラーがなく、httpResponceのステータスに異常がない
            if (error != nil) {
                print(error!)
                return
            } else {
                guard let httpResponse = response as? HTTPURLResponse  else {
                    return
                }
                
                // レスポンスに異常があるとき処理を継続しない
                if httpResponse.statusCode >= 400 {
                    return
                }
            }
            
            // dataがnilならば実行しない
            guard let data = data else {
                return
            }
            
            // この先の処理がnilならば実行しない
            guard let handler = handler else {
                return
            }

            handler(data)

        }
        dataTask.resume()
    }
}
