//
//  ImageViewPresenter.swift
//  Viper Demo
//
//  Created by Raghavendra Mikkilineni on 15/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit

protocol ImageViewPresenterProtocol: AnyObject {
    var interactor: ImageViewInteractorProtocol? { get set }
    var view: ImageViewProtocol? { get set }
    func getImage(_ imageURL: String)
    func displayImage(_ image: UIImage?)
}

class ImageViewPresenter: ImageViewPresenterProtocol {
    var interactor: ImageViewInteractorProtocol?
    weak var view: ImageViewProtocol?
    
    func getImage(_ imageURL: String) {
        interactor?.getImage(imageURL: imageURL)
    }
    
    func displayImage(_ image: UIImage?) {
        guard let image = image else { return }
        view?.displayImage(image: image)
    }
}
