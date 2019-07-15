//
//  APIRequestService.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation
import Reachability

class APIRequestService {
    
    func loadDataAPI(url: String, session: URLSession = URLSession(configuration: .default), completion: @escaping (APIResult<Data, APIError>) -> Void) -> URLSessionTask? {
        
        guard let url = URL(string: url) else {
            completion(.failure(.networkError(string: "Bad format url")))
            return nil
        }
        
        var apiRequest = APIRequest.apiRequest(method: .GET, url: url)
        
        if let reachability = Reachability(), reachability.connection == .none {
            apiRequest.cachePolicy = .returnCacheDataDontLoad
        }
        
        let task = session.dataTask(with: apiRequest) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(string: "NetworkErrorMessage".localize + error.localizedDescription)))
                return
            }
            
            if let data = data {
                completion(.success(data))
            }
        }
        
        task.resume()
        return task
        
    }
    
}
