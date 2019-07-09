//
//  DataParser.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

protocol Parsable {
    static func parseObject(dictionary: [String: AnyObject]) -> APIResult<Self, APIError>
    
}

final class ParserData {
    
    static func parseData<T: Parsable>(data: Data, completion: (APIResult<T, APIError>) -> Void) {
        
        do {
            if let dict = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: AnyObject] {
                
                switch T.parseObject(dictionary: dict) {
                case .failure(let error):
                    completion(.failure(error))
                    break
                case .success(let model):
                    completion(.success(model))
                    break
                }
            } else {
                
                print("Not array")
                completion(.failure(.parserError(string: "APIParseErrorMessage".localize)))
            }
        } catch  {
            print("Parse error")
        }
        
    }
    
}
