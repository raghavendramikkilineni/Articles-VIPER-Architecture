//
//  ArticlesViewController.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import UIKit

protocol ArticlesViewProtocol: AnyObject {
    var presenter: ArticlesPresenterProtocol? { get set }
    func showArticles()
    func showError()
}

class ArticlesViewController: UIViewController, ArticlesViewProtocol {
    var presenter: ArticlesPresenterProtocol?
    var pageSize = 50
    var page = 1
    @IBOutlet weak var tableViewArticle: UITableView!
    
    init(presenter: ArticlesPresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewArticle.estimatedRowHeight = 100
        self.tableViewArticle.rowHeight = UITableView.automaticDimension
        self.tableViewArticle.register(UINib(nibName: "ArticleTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticleTableViewCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.getArticles(query: "tesla", from: "2022-01-26", sortBy: "publishedAt", pageSize: pageSize, page: page)
    }
    
    func showArticles() {
        DispatchQueue.main.async {
            self.tableViewArticle.reloadData()
        }
    }
    
    func showError() {
        DispatchQueue.main.async {
            
        }
    }
}

extension ArticlesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfRowsInSection(section: section) ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let articleCell: ArticleTableViewCell = tableViewArticle.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as! ArticleTableViewCell
        articleCell.setArticleCell(presenter?.getObjectAtIndex(index: indexPath.row) ?? Article.mock())
        return articleCell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       presenter?.goToArticleDetail(with: indexPath)
    }
}
