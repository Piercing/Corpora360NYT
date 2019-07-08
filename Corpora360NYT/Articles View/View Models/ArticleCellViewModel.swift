//
//  ArticleCellViewModel.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

struct ArticleCellViewModel {
    
    var title: String?
    var byLineString: String?
    var section: String?
    var publishedData: Date?
    var imageURL: String?
    
    init(article: Article) {
        
        self.title = article.title
        self.byLineString = article.byLineString
        self.section = article.section
        self.publishedData = article.publishedData
        self.imageURL = article.imageUrl
    }
}
