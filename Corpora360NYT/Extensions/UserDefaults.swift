//
//  UserDefaults.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation

enum ArticleNotation: Int {
    case mostMailed
    case mostShared
    case mostViewed
    
    var articleNotation: String {
        switch self {
        case .mostMailed: return "mostemailed"
        case .mostShared: return "mostshared"
        case .mostViewed: return "mostviewed"
            
        }
    }
    
}

enum PeriodNotation: Int {
    case period01
    case period07
    case period30
    
    var periodNotation: String {
        switch self {
        case .period01: return "1"
        case .period07: return "7"
        case .period30: return "30"
        }
    }
    
}

enum SourceNotation: Int {
    case facebook
    case twitter
    
    var sourceNotation: String {
        switch self {
        case .facebook: return "facebook"
        case .twitter : return "twitter"
        }
    }
    
}

struct UserDefaultsKey {
    static let articleNotation = "articleNotation"
    static let periodNotation  = "periodNotation"
    static let sourceNotation  = "sourceNotation"
}

extension UserDefaults {
    
    // MARK: - Article Notation
    
    static func articleNotation() -> ArticleNotation {
        let storedValue = UserDefaults.standard.integer(forKey: UserDefaultsKey.articleNotation)
        return ArticleNotation(rawValue: storedValue) ?? ArticleNotation.mostViewed
    }
    
    static func setArticleNotation(articleNotation: ArticleNotation) {
        UserDefaults.standard.set(articleNotation.rawValue, forKey: UserDefaultsKey.articleNotation)
    }
    
    // MARK: - Period Notation
    
    static func periodNotation() -> PeriodNotation {
        let storeValue = UserDefaults.standard.integer(forKey: UserDefaultsKey.periodNotation)
        return PeriodNotation(rawValue: storeValue) ?? PeriodNotation.period01
    }
    
    static func setPeriodNotation(periodNotation: PeriodNotation) {
        UserDefaults.standard.set(periodNotation.rawValue, forKey: UserDefaultsKey.periodNotation)
    }
    
    // MARK: - Source Notation
    
    static func sourceNotation() -> SourceNotation {
        let storeValue = UserDefaults.standard.integer(forKey: UserDefaultsKey.sourceNotation)
        return SourceNotation(rawValue: storeValue) ?? SourceNotation.facebook
    }
    
    static func setSourceNotation(sourceNotation: SourceNotation) {
        UserDefaults.standard.set(sourceNotation.rawValue, forKey: UserDefaultsKey.sourceNotation)
    }
    
}



