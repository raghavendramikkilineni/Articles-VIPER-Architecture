//
//  Router.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 25/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit

protocol NewsRouterProtocol: AnyObject {
    static func createArticlesView() -> UIViewController?
    func viewArticle(articleId: String, view: UIViewController)
}


class NewsRouter: NewsRouterProtocol {
    static func createArticlesView() -> UIViewController? {
        if let articlesViewController: ArticlesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticlesViewController") as? ArticlesViewController {
            
            let articleInteractor = ArticleInteractor(container: AppDelegate.bootStarp())
            let router = NewsRouter()
            let articlePresenter = ArticlesPresenter(interactor: articleInteractor, router: router)
            
            articleInteractor.presenter = articlePresenter
            
            articlePresenter.view = articlesViewController
            
            articlesViewController.presenter = articlePresenter
            
            let navigationController = UINavigationController(rootViewController: articlesViewController)
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationItem.title = "News"
            return navigationController
        }
        return nil
    }
    
    func viewArticle(articleId: String, view: UIViewController) {
        if let articleDetailVC = NewsDetailRouter.createNewsDetailView(articleId: articleId) {
            view.navigationController?.pushViewController(articleDetailVC, animated: true)
        }
    }
}
