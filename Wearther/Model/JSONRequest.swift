//
//  JSONRequest.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation
import UIKit

/// JsonをDecodeする処理のまとまり
class Decoder<T: Decodable> {
    
    
    /// decode
    /// JSONを受け取って分解する処理
    /// - Parameter data: 受け取ったJSONデータ
    func decode(data: Data) {
        let decoder = JSONDecoder()
        
        do {
            let item = try decoder.decode(T.self, from: data)

            // 通知を送る
            NotificationCenter.default.post(name: .update, object: self, userInfo: ["item": item])
            
        } catch {
            print(error)
        }
    }
}
