//
//  File.swift
//  
//
//  Created by Berkay Sancar on 8.02.2024.
//

import Foundation

public struct CoinDetailDTO: Codable {
    public let symbol, name: String
    public let description: Language
    public let links: Link
}

public struct Link: Codable {
    public let homepage: [String]
}

// MARK: - Languages
public struct Language: Codable {
    public let en, de, es, fr: String
    public let it, pl, ro, hu: String
    public let nl, pt, sv, vi: String
    public let tr, ru, ja, zh: String
    public let zhTw, ko, ar, th: String
    public let id, cs, da, el: String
    public let hi, no, sk, uk: String
    public let he, fi, bg, hr: String
    public let lt, sl: String

    enum CodingKeys: String, CodingKey {
        case en, de, es, fr, it, pl, ro, hu, nl, pt, sv, vi, tr, ru, ja, zh
        case zhTw = "zh-tw"
        case ko, ar, th, id, cs, da, el, hi, no, sk, uk, he, fi, bg, hr, lt, sl
    }
}
