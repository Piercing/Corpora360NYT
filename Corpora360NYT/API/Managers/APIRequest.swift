//
//  APIRequest.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

final class APIRequest {
    
    enum HTTPMethod: String {
        case GET
        case POST
        case DELETE
        case UPDATE
        case PUT
        
    }
    
    static func apiRequest(method: HTTPMethod, url: URL) -> URLRequest {
        var apiRequest = URLRequest(url: url)
        apiRequest.httpMethod = method.rawValue
        return apiRequest
        
    }
    
}
