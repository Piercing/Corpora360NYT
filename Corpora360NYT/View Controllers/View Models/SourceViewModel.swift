//
//  SourceViewModel.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

class SourceViewModel {
    private var source: SourceModel
    
    var isSelected = false
    var title: String {
        return source.socialPlatform
    }
    
    init(source: SourceModel) {
        self.source = source
    }
}
