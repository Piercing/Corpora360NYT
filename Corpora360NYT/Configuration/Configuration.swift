//
//  Configuration.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import Foundation


struct Defaults {
    
    // Instance variables
    static var articleType: String = ""
    static var sourceType : String = ""
    static var periodType : Int    = 1
    
    enum SourceTypeSocialRed: String {
        case facebook = "facebook"
        case twitter  = "twitter"
    }
    
}

struct API {
    
    static var getPeriodType: Int {
        
        get { return Defaults.periodType }
        set (newPeriodType) {
            if newPeriodType != getPeriodType {
                Defaults.periodType = newPeriodType
            }
        }
        
    }
    
    static var getArticleType: String {
        
        get { return Defaults.articleType }
        set (newArticleType) {
            if newArticleType != getArticleType {
                Defaults.articleType = newArticleType
            }
        }
        
    }
    
    static var getSourceType: String {
        
        get { return Defaults.sourceType }
        set (newSourceType) {
            if newSourceType != getSourceType {
                Defaults.sourceType = newSourceType
            }
        }
        
    }
    
    static let APIKey  = "hg7IA4Gfku3AaaVwrA5hSEgfpF0AqAoi"
    static let Section = "all-sections"
    static let BaseURL = URL(string: "http://api.nytimes.com/svc/mostpopular/v2/")!
    static let ArticleApiURL = "/\(getArticleType)"  + "/\(Section)" + "/\(getPeriodType)" + ".json?api-key=\(APIKey)"
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(ArticleApiURL)
    }
    
}










// API URLs
//    enum Periods: Int {
//        case period01 = 1
//        case period07 = 7
//        case period30 = 30
//        case unknown
//
//        init(value: Int) {
//            if let period = Periods(rawValue: value) { self = period }
//            else { self = .unknown }
//        }
//    }


//    static let EmailedBaseURL = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/"
//    static let ViewedBaseURL  = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/"
//    static let SharedBaseURL  = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/"
