//
//  ArticlesPresenter.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit
protocol ArticlesPresenterProtocol: AnyObject {
    var interactor: ArticlesInteractorProtocol { get set }
    var view: ArticlesViewProtocol? { get set }
    var router: NewsRouter { get set }
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int)
    func showArticles()
    func showError()
    func numberOfRowsInSection(section: Int) -> Int
    func getObjectAtIndex(index: Int) -> Article
    func goToArticleDetail(with indexPath: IndexPath)
}

class ArticlesPresenter: ArticlesPresenterProtocol {
    var interactor: ArticlesInteractorProtocol
    weak var view: ArticlesViewProtocol?
    var router: NewsRouter
    
    init(interactor: ArticlesInteractorProtocol, router: NewsRouter) {
        self.interactor = interactor
        self.router = router
    }
    
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int) {
        interactor.getArticles(query: query, from: from, sortBy: sortBy, pageSize: pageSize, page: page)
    }
    
    func showArticles() {
        view?.showArticles()
    }
    
    func showError() {
        view?.showError()
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return interactor.numberOfRowsInSection(section: section)
    }
    
    func getObjectAtIndex(index: Int) -> Article {
         return interactor.getObjectAtIndex(index: index)
    }
    
    func goToArticleDetail(with indexPath: IndexPath) {
        let article = interactor.getObjectAtIndex(index: indexPath.row)
        router.viewArticle(articleId: article.url, view: view as! UIViewController)
    }
}
