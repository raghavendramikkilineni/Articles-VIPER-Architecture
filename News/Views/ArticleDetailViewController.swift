//
//  ArticleDetailViewController.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 25/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    var articleId: String
    
    init(articleId: String) {
        self.articleId = articleId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.articleId = ""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Detail loaded \(articleId)")
    }
}
