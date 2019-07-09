//
//  SettingsViewArticleViewModel.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

struct SettingsViewArticleViewModel {
    
    // MARK: - Properties
    
    let articleNotation: ArticleNotation
    
    var text: String {
        switch articleNotation {
        case .mostMailed: return "Most Mailed"
        case .mostShared: return "Most Shared"
        case .mostViewed: return "Most Viewed"
        }
        
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.articleNotation() == articleNotation {
            return .checkmark
        } else {
            return .none
        }
        
    }
    
}

extension SettingsViewArticleViewModel: SettingsRepresentable {
    
}
