//
//  AppDelegate.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
     
        window = UIWindow(frame: UIScreen.main.bounds)
        if let articlesViewController: ArticlesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ArticlesViewController") as? ArticlesViewController {
            
            let articleInteractor = ArticleInteractor(container: AppDelegate.bootStarp())
            
            let articlePresenter = ArticlesPresenter(interactor: articleInteractor)
          
            articleInteractor.presenter = articlePresenter
    
            articlePresenter.view = articlesViewController
            
            articlesViewController.presenter = articlePresenter
            
            let navigationController = UINavigationController(rootViewController: articlesViewController)
            navigationController.navigationBar.barStyle = .black
            navigationController.navigationItem.title = "News"
            window?.rootViewController = navigationController
            window?.makeKeyAndVisible()
        }
        return true
    }
}

extension AppDelegate {
    static func bootStarp() -> DIContainer {
        let urlSession = URLSession(configuration: .default)
        let webRepository = RealWebRepository(urlSession: urlSession)
        let newsService = RealNewsService(webRepository: webRepository)
        let imageService = RealImageService(webRepository: webRepository)
        let services = Services(newsService: newsService,
                                imageService: imageService)
       return DIContainer(services: services)
    }
}
