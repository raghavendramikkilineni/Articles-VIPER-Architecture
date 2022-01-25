//
//  ImageService.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit

protocol ImageService {
    func download(imageURL: String, onCompletion: @escaping (UIImage?, Error?) -> Void)
}

struct RealImageService: ImageService {
    let webRepository: WebRepository
    init(webRepository: WebRepository) {
        self.webRepository = webRepository
    }
    
    func download(imageURL: String, onCompletion: @escaping (UIImage?, Error?) -> Void) {
        
        if let image = AsyncImageCache.shared[imageURL] {
            onCompletion(image, nil)
        } else {
            webRepository.download(imageURL: imageURL) { (data, error) in
                guard let data = data, error == nil else {
                    onCompletion(nil, error)
                    return
                }
                if let image = UIImage(data: data) {
                    AsyncImageCache.shared.setImage(image: image, url: imageURL)
                    onCompletion(image, nil)
                } else {
                    onCompletion(nil, NetworkError.other(message: "image formation failed."))
                }
            }
        }
    }
}
