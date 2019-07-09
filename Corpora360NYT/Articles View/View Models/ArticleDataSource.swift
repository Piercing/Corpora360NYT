//
//  ArticleDataSource.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

class GenericDataSource<T>: NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
    
}


class ArticleDataSource: GenericDataSource<ArticleCellViewModel>, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cell configuration
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleCell".localize, for: indexPath) as! ArticleTableViewCell
        cell.selectionStyle = .none
        cell.CellUI()
        
        // Set cell data
        let articleCellVM = self.data.value[indexPath.row]
        cell.articleCellVM = articleCellVM
        return cell
        
    }
    
}
