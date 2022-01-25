//
//  ImageViewInteractor.swift
//  Viper Demo
//
//  Created by Raghavendra Mikkilineni on 15/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit

protocol ImageViewInteractorProtocol {
    var presenter: ImageViewPresenterProtocol? { get set }
    func getImage(imageURL: String)
}

class ImageViewInteractor: ImageViewInteractorProtocol {
    weak var presenter: ImageViewPresenterProtocol?
    var container: DIContainer
    
    init(container: DIContainer) {
        self.container = container
    }
    var imageArticle: UIImage?
    
    func getImage(imageURL: String) {
        container.services.imageService.download(imageURL: imageURL) { [weak self] (image, error) in
            guard let image = image, error == nil else { return }
            self?.imageArticle = image
            self?.presenter?.displayImage(self?.imageArticle)
        }
    }
}
