//
//  URLRequestElement.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

protocol URLRequestElement {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParameters { get }
    var headers: [String: String] { get }
    var parametersEncoding: ParameterEncoding { get }
}

extension URLRequestElement {
    func createURLRequest(baseURL: URL) throws -> URLRequest{
        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        return try parametersEncoding.encode(&urlRequest, with: parameters)
    }
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
    case head = "HEAD"
}

struct RequestParameters {
    let urlParameters: [String: String]?
    let bodyParameters: [String: Any]?
    let contentType: HeaderContentType
}

enum HeaderContentType: String {
    case json = "application/json"
}

enum HTTPHeaderKeys: String {
    case contentType = "Content-Type"
    case cookie = "Cookie"
}

