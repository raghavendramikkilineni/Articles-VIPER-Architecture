//
//  AsyncImageView.swift
//  Viper Demo
//
//  Created by Raghavendra Mikkilineni on 15/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import UIKit

protocol ImageViewProtocol: AnyObject {
    var presenter: ImageViewPresenterProtocol? { get set }
    func displayImage(image: UIImage)
    func getImage()
}

class AsyncImageView: UIView, ImageViewProtocol {
    var presenter: ImageViewPresenterProtocol?
    var imageURL: String
    var imageViewArticle: UIImageView?
    
    init(imageURL: String) {
        self.imageURL = imageURL
        super.init(frame: CGRect())
        presenter?.getImage(imageURL)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        imageURL = ""
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        if imageViewArticle == nil {
            let imageView = UIImageView(image: UIImage(named: "placeholder"))
            imageViewArticle = imageView
            imageViewArticle?.frame = self.bounds
            imageViewArticle?.contentMode = .scaleAspectFit
            imageViewArticle?.clipsToBounds = true
            self.addSubview(imageViewArticle!)
        }
    }
    
    func displayImage(image: UIImage) {
        DispatchQueue.main.async { [weak self] in
            self?.imageViewArticle?.image = image
        }
    }
    
    func getImage() {
        presenter?.getImage(imageURL)
    }
}


