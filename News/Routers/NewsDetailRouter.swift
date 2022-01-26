//
//  NewsDetailRouter.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 26/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit

protocol NewsDetailRouterProtocol: AnyObject {
    static func createNewsDetailView(articleId: String) -> UIViewController?
}

class NewsDetailRouter: NewsDetailRouterProtocol {
    static func createNewsDetailView(articleId: String) -> UIViewController? {
        if let articlesViewController: ArticleDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticleDetailViewController") as? ArticleDetailViewController {
            articlesViewController.articleId = articleId
//            let articleInteractor = ArticleInteractor(container: AppDelegate.bootStarp())
//
//            let articlePresenter = ArticlesPresenter(interactor: articleInteractor)
//
//            articleInteractor.presenter = articlePresenter
//
//            articlePresenter.view = articlesViewController
//
//            articlesViewController.presenter = articlePresenter
          
            return articlesViewController
        }
        return nil
    }
}
