//
//  ParameterEncoding.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

protocol ParameterEncoding {
    func encode(_ urlRequest: inout URLRequest, with requestParameters: RequestParameters) throws -> URLRequest
}

struct RequestEncoding: ParameterEncoding {
    func encode(_ urlRequest: inout URLRequest, with requestParameters: RequestParameters) throws -> URLRequest {
        guard let url = urlRequest.url else { throw NetworkError.malformedURL }
        
        if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false),
            let urlParameters = requestParameters.urlParameters, !urlParameters.isEmpty {
            urlComponents.queryItems = [URLQueryItem]()
            for(key, value) in urlParameters {
                let urlQueryItem = URLQueryItem(name: key, value: value)
                urlComponents.queryItems?.append(urlQueryItem)
            }
            urlRequest.url = urlComponents.url
        }
        
        if let bodyParameters = requestParameters.bodyParameters, !bodyParameters.isEmpty {
            do {
                switch requestParameters.contentType {
                case .json:
                    return try self.enodeJson(&urlRequest, with: bodyParameters)
                }
            } catch {
                throw NetworkError.parametersEncodingFailed
            }
        }
        return urlRequest
    }
    
    private func enodeJson(_ urlRequest: inout URLRequest, with parameters: [String: Any]) throws -> URLRequest {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
            urlRequest.httpBody = jsonData
            urlRequest.setValue(HeaderContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderKeys.contentType.rawValue)
            return urlRequest
        } catch {
            throw NetworkError.parametersEncodingFailed
        }
    }
}

