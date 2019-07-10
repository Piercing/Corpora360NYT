//
//  NetService.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

protocol APIServiceProtocol: class {
    func getArticles(_ completion: @escaping ((APIResult<Articles, APIError>) -> Void))
    
}

// MARK: - Service

enum APIResult<T, E: Error> {
    case success(T)
    case failure(E)
    
}

enum APIError: Error {
    case networkError(string: String)
    case parserError (string: String)
    case customizedError (string: String)
    
}

final class NetService: APIRequestHandler, APIServiceProtocol {
    
    static var url: String!
    
    static let netService = NetService()
    var netTask: URLSessionTask?
    
    func getArticles(_ completion: @escaping ((APIResult<Articles, APIError>) -> Void)) {
        
        // Cancel previous request
        self.cancelGetAritcles()
        netTask = APIRequestService().loadDataAPI(url: API.finalURL, completion: self.netResult(completion: completion))
        
        print(API.finalURL)
        
    }
    
    func cancelGetAritcles() {
        if let netTask = netTask {
            netTask.cancel()
        }
        netTask = nil
        
    }
    
}
