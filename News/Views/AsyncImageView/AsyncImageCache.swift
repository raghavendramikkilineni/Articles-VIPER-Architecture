//
//  AsyncImageCache.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 25/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation
import UIKit

protocol ImageCache {
    func setImage(image: UIImage?, url: String)
    func getImage(_ url: String) -> UIImage?
    func remove(_ url: String)
    func removeAll()
    subscript(_ url: String) -> UIImage? { get set }
}

class AsyncImageCache: ImageCache {
    private init() {}
    static let shared = AsyncImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    func setImage(image: UIImage?, url: String) {
        guard let image = image else { return remove(url) }
        cache.setObject(image, forKey: url as NSString)
    }
    
    func getImage(_ url: String) -> UIImage? {
       return cache.object(forKey: url as NSString)
    }
    
    func remove(_ url: String) {
         cache.removeObject(forKey: url as NSString)
    }
    
    func removeAll() {
        cache.removeAllObjects()
    }
    
    subscript(url: String) -> UIImage? {
        get {
           return getImage(url)
        }
        set {
            setImage(image: newValue, url: url)
        }
    }
}
