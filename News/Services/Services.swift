//
//  Services.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

struct Services {
    var newsService: NewsService
    var imageService: ImageService
    init(newsService: NewsService, imageService: ImageService) {
        self.newsService = newsService
        self.imageService = imageService
    }
}
