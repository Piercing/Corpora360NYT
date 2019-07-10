//
//  SettingsRepresentable.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit

protocol SettingsRepresentable {
    
    var text: String { get }
    var accessoryType: UITableViewCell.AccessoryType { get }  
    
}
