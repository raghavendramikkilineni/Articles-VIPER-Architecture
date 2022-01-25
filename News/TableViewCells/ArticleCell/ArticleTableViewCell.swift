//
//  NewsTableViewCell.swift
//  Viper Demo
//
//  Created by Raghavendra Mikkilineni on 15/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var asyncImageView: AsyncImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setArticleCell(_ article: Article) {
        self.labelTitle.text = article.title
        self.labelDescription.text = article.description
        asyncImageView.imageURL = article.imageURL ?? ""
        setupViperToDownloadImage()
    }
    
   private func setupViperToDownloadImage() {
        let presenter = ImageViewPresenter()
        let interactor = ImageViewInteractor(container: AppDelegate.bootStarp())
        
        asyncImageView.presenter = presenter
        
        presenter.interactor = interactor
        presenter.view = asyncImageView
        
        interactor.presenter = presenter
        asyncImageView.getImage()
        asyncImageView.clipsToBounds = true
    }
}

