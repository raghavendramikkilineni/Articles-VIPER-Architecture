//
//  WebRepository.swift
//  News
//
//  Created by Raghavendra Mikkilineni on 17/01/22.
//  Copyright © 2022 Raghavendra Mikkilineni. All rights reserved.
//

import Foundation

protocol WebRepository {
    func call<T: Decodable>(endPoint: URLRequestElement, onCompletion: @escaping (Result<T>) -> Void)
    func download(imageURL: String, onCompletion: @escaping (Data?, Error?) -> Void)
}

struct RealWebRepository: WebRepository {
    let urlSession: URLSession
    init(urlSession: URLSession) {
        self.urlSession = URLSession(configuration: urlSession.configuration)
    }
    
    func call<T: Decodable>(endPoint: URLRequestElement, onCompletion: @escaping (Result<T>) -> Void) {
        do {
            let urlRequest = try createURLRequest(endPoint)
            let dataTask = urlSession.dataTask(with: urlRequest) { (data, response, error) in
                
                if let _ = error {
                    onCompletion(.failure(NetworkError.failed))
                    return
                }
                
                guard let urlResponse = response, let data = data  else {
                    onCompletion(.failure(NetworkError.noResponseData))
                    return
                }
                
                let responseStatus = self.isValidResposne(response: urlResponse as! HTTPURLResponse)
                
                switch responseStatus {
                case .success:
                    do {
                        let value = try JSONDecoder().decode(T.self, from: data)
                        onCompletion(.success(value))
                    } catch let error {
                        onCompletion(.failure(error))
                    }
                case let .failure(error):
                    onCompletion(.failure(error))
                }
            }
            dataTask.resume()
        } catch let error {
            onCompletion(.failure(error))
        }
    }
    
    private func createURLRequest(_ endpoint: URLRequestElement) throws -> URLRequest {
        do {
            return try endpoint.createURLRequest(baseURL: URL(string: Constants.baseURL)!)
        } catch let error {
            throw error
        }
    }
    
    func download(imageURL: String, onCompletion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: imageURL), !imageURL.isEmpty else { return }
        let dataTask = urlSession.dataTask(with: url) { (data, response, error) in
            guard let data = data else {
                onCompletion(nil, NetworkError.failed)
                return
            }
            onCompletion(data, nil)
        }
        dataTask.resume()
    }
    
    func isValidResposne(response: HTTPURLResponse) -> Result<Any> {
        switch response.statusCode{
        case 200...299:
            return .success("Valid response")
        case 401:
            return .failure(NetworkError.authenticationError)
        case 500:
            return .failure(NetworkError.badRequest)
        default:
            return .failure(NetworkError.failed)
        }
    }
}

enum Result<T> {
    case success(T)
    case failure(Error)
}
