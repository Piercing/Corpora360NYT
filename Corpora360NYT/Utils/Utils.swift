//
//  Utils.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 08/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

class Utils {
    static func convertDataToString(date: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yy-MM-dd"
        guard let date = dateFormatter.date(from: date) else {
            print("Don't possible conversion.")
            return Date()
        }
        return date
    }
}
