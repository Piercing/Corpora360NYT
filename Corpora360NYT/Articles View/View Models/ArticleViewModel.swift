//
//  ArticleViewModel.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

struct ArticleViewModel {
    
    weak var dataSource: GenericDataSource<ArticleCellViewModel>?
    weak var serviceProtocolAPI: APIServiceProtocol?
    
    init(service: APIServiceProtocol = NetService.netService, dataSource: GenericDataSource<ArticleCellViewModel>?) {
        self.dataSource = dataSource
        self.serviceProtocolAPI = service
        
    }
    
    func getArticles(_ completion: ((APIResult<Bool, APIError>) -> Void)? = nil) {
        
        guard let service = serviceProtocolAPI else {
            completion?(APIResult.failure(APIError.customizedError(string: "Not service available")))
            return
            
        }
        
        service.getArticles() { result in
            
            DispatchQueue.main.async {
                switch result {
                case . success(let metaData):
                    var articles = metaData.articles
                    
                    articles = articles.sorted(by: { $0.publishedData > $1.publishedData})
                    self.dataSource?.data.value = self.getArticleCellViewModel(articles: articles)
                    completion?(APIResult.success(true))
                    break
                    
                case .failure(let error):
                    print("Parse error \(error)")
                    completion?(APIResult.failure(error))
                    break
                }
            }
        }
        
    }
    
    func  getArticleCellViewModel(articles:[Article]) -> [ArticleCellViewModel] {
        var articalCellVMList = [ArticleCellViewModel]()
        for article in articles {
            let articleCellViewModel = ArticleCellViewModel(article: article)
            articalCellVMList.append(articleCellViewModel)
        }
        
        return articalCellVMList
    }
    
}
