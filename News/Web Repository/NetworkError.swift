//
//  NetworkError.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case parametersNil
    case parametersEncodingFailed
    case malformedURL
    case authenticationError
    case badRequest
    case failed
    case noResponseData
    case unabletoDecodeResponseData(errorDescription: String)
    case other(message: String?)
    
    var localizedDescription: String {
        var message: String = ""
        switch self {
        case .parametersNil:
            message = "Empty parameters"
        case .parametersEncodingFailed:
            message = "Failed to encode request parameters"
        case .malformedURL:
            message = "Malformed URL"
        case .authenticationError:
            message = "Authentication Failed"
        case .badRequest:
            message = "Bad Request"
        case .failed:
            message = "API request failed"
        case .noResponseData:
            message = "Empty response data"
        case .unabletoDecodeResponseData(let errorDescription):
            message = "Unable to decode response object: \(errorDescription)"
        case let .other(errorMessage):
            message = errorMessage ?? "unknown error"
        }
        return message
    }
}
