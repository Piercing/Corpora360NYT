//
//  Articles.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

struct Articles {
    var articles: [Article]
    
}

extension Articles: Parsable {
    
    static func parseObject(dictionary: [String: AnyObject]) -> APIResult<Articles, APIError> {
        if let dictResults = dictionary["results"] as? [[String: Any]] {
            let articlesResults = dictResults.map( { Article(articleDictionary: $0)}).compactMap{ $0 }
            let metaData = Articles(articles: articlesResults)
            return APIResult.success(metaData)
        } else  {
            return APIResult.failure(APIError.parserError(string: "Could not parse response"))
        }
    }
    
}

struct Article {
    var title: String?
    var section: String?
    var imageUrl: String?
    var publishedData: Date!
    var byLineString: String?
    
    init?(articleDictionary: Dictionary<String, Any>) {
        guard let _ = articleDictionary["title"] as? String else { return nil }
        
        self.title = articleDictionary["Title".localize] as? String
        self.byLineString = articleDictionary["ByLine".localize] as? String
        self.section = articleDictionary["Section".localize] as? String
        
        if let dateString = articleDictionary["PublishedDate".localize] as? String {
            self.publishedData = Utils.convertDataToString(date: dateString)
        }
        
        if let mediaData = articleDictionary["Media".localize] as? [Dictionary<String, Any>] {
            if let mediaMetaData = mediaData.first?["MediaMetaData".localize] as? [Dictionary<String, Any>] {
                self.imageUrl = mediaMetaData.first?["Url".localize] as? String
            }
        }
        
    }
    
}





