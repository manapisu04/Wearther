//
//  TNQLRequest.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

class TNQLRequest {

    static func request(handler: ((Data) -> ())? = nil) {
        
        guard let xRapidApiKey = TNQLProperties.shared.value(of: "TNQL_X_RapidAPI_Key"),
              let xRapidApiHost = TNQLProperties.shared.value(of: "TNQL_X_RapidAPI_Host"),
              let domain = TNQLProperties.shared.value(of: "TNQL_Domain"),
              let endPoint = TNQLProperties.shared.value(of: "TNQL_EndPoint") else {
            return
        }
        
        let headers = [
            "x-rapidapi-key": xRapidApiKey,
            "x-rapidapi-host": xRapidApiHost
        ]
        
        guard let url = URL(string: domain + endPoint) else { return }
        
        // urlが解決できているので、urlを強制アンラップする
        var components = URLComponents(url: url, resolvingAgainstBaseURL: true)!
        // TNQLのairportの指定は固定（羽田）
        components.queryItems = [URLQueryItem(name: "airport", value: "HND")]
        
        // リクエストを作成する
        var request = URLRequest(url: components.url!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        // TNQLのmethodはGET
        request.httpMethod = "GET"
        // TNQLの指定
        request.allHTTPHeaderFields = headers
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { data, response, error in
            // sessionを終了する
            session.finishTasksAndInvalidate()
            
            // エラーがない、かつhttpResponseのステータスに異常がない
            if (error != nil) {
                print(error!)
                return
            } else {
                guard let httpResponse = response as? HTTPURLResponse  else {
                    return
                }
                
                // レスポンス異常であれば処理を継続しない
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
