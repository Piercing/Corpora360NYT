//
//  ArticleTableViewCell.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit
import SDWebImage

class ArticleTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var articleImageView: UIImageView!

    var articleCellVM: ArticleCellViewModel? {
        didSet {
            guard let articleCellVM = articleCellVM else {
                return
            }
            
            titleLabel.text   = articleCellVM.title
            authorLabel.text  = articleCellVM.byLineString
            sectionLabel.text = articleCellVM.section
            dateLabel.text    = Utils.convertStringToDate(date: articleCellVM.publishedData ?? Date())
            
            if let URLString = articleCellVM.imageURL {
                let url = URL(string: URLString)
                articleImageView.sd_setShowActivityIndicatorView(true)
                articleImageView.sd_setIndicatorStyle(.gray)
                articleImageView.sd_setImage(with: url, completed: nil)
                
            }
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func CellUI() {
        self.titleLabel?.textColor  = API.PrimaryTextColor
        self.authorLabel?.textColor = API.SecondryTextColor
        self.dateLabel?.textColor   = API.SecondryTextColor
        self.articleImageView.layer.cornerRadius = 10
    }
    
}
