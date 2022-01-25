//
//  NewsModel.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

struct NewsModel: Codable {
    let status: String
    let articles: [Article]?
    let totalResults: Int?
}

struct Article: Codable {
    let author: String?
    let title: String
    let description: String
    let url: String
    let imageURL: String?
    let publishedAt: String
    let source: Source?
    let content: String
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, publishedAt, source, content
        case imageURL = "urlToImage"
    }
}

struct Source: Codable {
    let id: String?
    let name: String
}

extension Article {
    static func mock() -> Article {
        return Article(author: "",
                       title: "",
                       description: "",
                       url: "",
                       imageURL: "",
                       publishedAt: "",
                       source: Source(id: "", name: ""),
                       content: "")
    }
}
