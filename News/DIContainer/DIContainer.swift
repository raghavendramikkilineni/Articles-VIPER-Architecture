//
//  DIContainer.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

struct DIContainer {
    var services: Services
    init(services: Services) {
        self.services = services
    }
}
