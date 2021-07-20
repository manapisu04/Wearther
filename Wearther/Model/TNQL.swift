//
//  TNQL.swift
//  Wearther
//
//  Created by cmStudent on 2021/07/19.
//

import Foundation

/// TNQLのJSONを受け取る構造体
struct TNQL: Decodable {
    let param: TNQLParameter?
    
    let results: TNQLResult
}

struct TNQLParameter: Decodable {
    /// 天気を観測する場所、空港
    let airport: String?
}

/// コーデの解説文
struct TNQLResult: Decodable {
    let a: [ResultItem]
    let b: [ResultItem]
    let c: [ResultItem]
}

/// コーデの解説の詳細
struct ResultItem: Decodable {
    /// コーデの画像
    let image: String
    
    /// コーデの解説文1
    let description1: String
    /// コーデの解説文2
    let description2: String
    /// コーデの解説文3
    let description3: String
}
