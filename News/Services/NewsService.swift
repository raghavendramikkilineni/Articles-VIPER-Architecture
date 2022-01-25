//
//  NewsService.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

protocol NewsService {
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int, onCompletion: @escaping (NewsModel?, Error?) -> Void)
}

struct RealNewsService: NewsService {
    let webRepository: WebRepository
    init(webRepository: WebRepository) {
        self.webRepository = webRepository
    }
    
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int, onCompletion: @escaping (NewsModel?, Error?) -> Void) {
        webRepository.call(endPoint: NewsEndPoint.getArticles(query: query,
                                                              from: from,
                                                              sortBy: sortBy,
                                                              pageSize: pageSize,
                                                              page: page,
                                                              apiKey: Constants.apiKey)) { (result: Result<NewsModel>) in
            switch result {
            case let .success(newsModel):
                onCompletion(newsModel, nil)
            case let .failure(error):
                onCompletion(nil, error)
            }
        }
    }
}
