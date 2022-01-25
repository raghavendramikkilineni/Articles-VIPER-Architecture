//
//  ArticlesPresenter.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

protocol ArticlesPresenterProtocol: AnyObject {
    var interactor: ArticlesInteractorProtocol { get set }
    var view: ArticlesViewProtocol? { get set }
    func getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int)
    func showArticles()
    func showError()
    func numberOfRowsInSection(section: Int) -> Int
    func getObjectAtIndex(index: Int) -> Article
}

class ArticlesPresenter: ArticlesPresenterProtocol {
    var interactor: ArticlesInteractorProtocol
    weak var view: ArticlesViewProtocol?
    
    init(interactor: ArticlesInteractorProtocol) {
        self.interactor = interactor
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
}
