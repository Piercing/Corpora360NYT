//
//  ArticleTableViewHeader.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

class ArticleTableViewHeader: UITableViewHeaderFooterView {
    
    @IBOutlet weak var headerLabel: UILabel!
    
    
    class var customView: ArticleTableViewHeader {
        let cell = Bundle.main.loadNibNamed("ArticleTableViewHeader", owner: self, options: nil)?.last
        return cell as! ArticleTableViewHeader
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
