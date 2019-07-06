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
    
}

enum PeriodNotation: Int {
    case period01
    case period07
    case period30
    
}

enum SourceNotation: Int {
    case facebook
    case twitter
    
}

struct UserDefaultsKey {
    static let articleNotation   = "articleNotation"
    static let periodNotation    = "periodNotation"
    static let sourceNotationFB  = "sourceNotationFB"
    static let sourceNotationTW  = "sourceNotationTW"

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
    
    // MARK: - Source Notation Facebook
    
    static func sourceNotationFB() -> SourceNotation {
        let storeValue = UserDefaults.standard.integer(forKey: UserDefaultsKey.sourceNotationFB)
        return SourceNotation(rawValue: storeValue) ?? SourceNotation.facebook
    }
    
    static func setSourceNotationFB(sourceNotation: SourceNotation) {
        UserDefaults.standard.set(sourceNotation.rawValue, forKey: UserDefaultsKey.sourceNotationFB)
    }
    
    // MARK: - Source Notation Twitter
    
    static func sourceNotationTW() -> SourceNotation {
        let storeValue = UserDefaults.standard.integer(forKey: UserDefaultsKey.sourceNotationTW)
        return SourceNotation(rawValue: storeValue) ?? SourceNotation.twitter
    }
    
    static func setSourceNotationTW(sourceNotation: SourceNotation) {
        UserDefaults.standard.set(sourceNotation.rawValue, forKey: UserDefaultsKey.sourceNotationTW)
    }
    
}



