//
//  SettingsTableViewCell.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    
    // MARK: - Type Properties
    
    static let reuseIdentifier = "SettingsCell"
    
    // MARK: - Properties
    
    @IBOutlet var mainLabelCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Configure Cell
        selectionStyle = .none
    }
    
    // MARK: - Configuration
    
    func configure(withViewModel viewModel: SettingsRepresentable) {
        mainLabelCell.text = viewModel.text
        accessoryType = viewModel.accessoryType
    }
    
}
