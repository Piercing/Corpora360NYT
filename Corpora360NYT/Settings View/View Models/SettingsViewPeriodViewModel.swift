//
//  SettingsViewPeriodViewModel.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

struct SettingsViewPeriodViewModel {
    
    // MARK: - Propierties
    
    let periodNotation: PeriodNotation
    
    // MARK: - Public Interface
    
    var text: String {
        switch periodNotation {
        case .period01: return "One Day"
        case .period07: return "Seven Days"
        case .period30: return "Thirty Days"
        }
        
    }
    
    var accessoryType: UITableViewCell.AccessoryType {
        if UserDefaults.periodNotation() == periodNotation {
            return .checkmark
        } else {
            return .none
        }
    }
    
}

extension SettingsViewPeriodViewModel: SettingsRepresentable {
    
}

