//
//  SettingsViewSourceViewModel.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

struct SettingsViewSourceViewModel {
    
    //MARK: - Porperties
    
    let sourceNotation: SourceNotation
    
    // MARK: - Public Interface
    
    var text: String {
        switch sourceNotation {
        case .facebook: return "Facebook"
        case .twitter : return "Twitter"
        }
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.sourceNotationFB() == sourceNotation && UserDefaults.sourceNotationTW() == sourceNotation{
            return .checkmark
        } else {
            return .none
        }
    }
}

extension SettingsViewSourceViewModel: SettingsRepresentable {
    
}
