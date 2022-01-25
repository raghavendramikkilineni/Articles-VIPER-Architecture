//
//  NewsEndPoint.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

enum NewsEndPoint: URLRequestElement {
   case getArticles(query: String, from: String, sortBy: String, pageSize: Int, page: Int, apiKey: String)
    
    var path: String {
        return self.components.joined(separator: "/")
    }
    
    private var components: [String] {
        switch self {
        case .getArticles:
            return ["v2", "everything"]
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getArticles:
            return .get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
         case let .getArticles(query, from, sortBy, pageSize, page, apiKey):
            let urlParameters = ["q": query, "from": from, "sortBy": sortBy, "pageSize": String(pageSize), "page": String(page), "apiKey": apiKey]
            return RequestParameters(urlParameters: urlParameters, bodyParameters: nil, contentType: .json)
        }
    }
    
    var headers: [String : String] {
        return [:]
    }
    
    var parametersEncoding: ParameterEncoding {
        switch self {
        case .getArticles:
            return RequestEncoding()
        }
    }
}
