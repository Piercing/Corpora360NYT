//
//  APIRequestHandler.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

class APIRequestHandler {
    
    func netResult<T: Parsable>(completion: @escaping ((APIResult<T, APIError>) -> Void)) -> ((APIResult<Data, APIError>) -> Void) {
        
        return { result in
            
            DispatchQueue.global(qos: .background).async(execute: {
                switch result {
                case .success(let data):
                    ParserData.parseData(data: data, completion: completion)
                    break
                case .failure(let error):
                    print("Net error \(error)")
                    completion(.failure(.networkError(string: "Net error: " + error.localizedDescription)))
                }
            })
        }
        
    }
    
}
