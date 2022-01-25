//
//  ArticlesInteractor.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

protocol ArticlesInteractorProtocol: AnyObject {
    var presenter: ArticlesPresenterProtocol? { get set }
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int)
    func numberOfRowsInSection(section: Int) -> Int
    func getObjectAtIndex(index: Int) -> Article
}

class ArticleInteractor: ArticlesInteractorProtocol {
    weak var presenter: ArticlesPresenterProtocol?
    let container: DIContainer
    var articles: [Article] = [Article]()
    init(container: DIContainer) {
        self.container = container
    }
    
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int) {
        DispatchQueue.global().async {
            self.container.services.newsService.getArticles(query: query, from: from, sortBy: sortBy, pageSize: pageSize, page: page, onCompletion: { [weak self] (newsModel, error) in
                guard let newsModel = newsModel, error == nil else {
                    self?.presenter?.showError()
                    return
                }
                self?.articles = newsModel.articles ?? []
                self?.presenter?.showArticles()
            })
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return articles.count
    }
    
    func getObjectAtIndex(index: Int) -> Article {
        return articles[index]
    }
}
