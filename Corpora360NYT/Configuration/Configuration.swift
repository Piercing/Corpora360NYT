//
//  Configuration.swift
//  Corpora360NYT
//
//  Created by Juan Carlos Merlos Albarracín on 06/07/2019.
//  Copyright © 2019 devspain. All rights reserved.
//

import UIKit


struct Defaults {
    
    static var articleType: String = ""
    static var periodType : String = ""
    static var sourceType : String = ""
    
}

struct API {
    
    static var getArticleType: String {
        get {
            Defaults.articleType = UserDefaults.articleNotation().articleNotation
            return Defaults.articleType
        }
        set (newArticleType) {
            if newArticleType != Defaults.articleType {
                Defaults.articleType = newArticleType
            }
        }
        
    }
    
    static var getPeriodType: String {
        get {
            Defaults.periodType = UserDefaults.periodNotation().periodNotation
            return Defaults.periodType
        }
        set (newPeriodType) {
            if newPeriodType != Defaults.periodType {
                Defaults.periodType = newPeriodType
            }
        }
        
    }
    
    static var getSourceType: String {
        get {
            Defaults.sourceType = UserDefaults.sourceNotation().sourceNotation
            return Defaults.sourceType
        }
        set (newSourceType) {
            if newSourceType != Defaults.sourceType {
                Defaults.sourceType = newSourceType
                
            }
        }
        
    }
    
    static let APIKey    = "hg7IA4Gfku3AaaVwrA5hSEgfpF0AqAoi"
    static let Section   = "all-sections"
    static let Facebook  = "facebook"
    static let Twitter   = "twitter"
    static let AllSocial = "facebook;twitter"
    static let BaseURL   = "https://api.nytimes.com/svc/mostpopular/v2"
    static var ArtApiURL = ""
    
    static var finalURL: String  {
        switch API.getSourceType {
            
        case "facebook":
            API.ArtApiURL = "/\(API.getArticleType)" + "/\(API.Section)" + "/\(API.Facebook)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
            print(API.getArticleType)
            return API.BaseURL + API.ArtApiURL
            
        case "twitter":
            API.ArtApiURL = "/\(API.getArticleType)" + "/\(API.Section)" + "/\(API.Twitter)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
            return API.BaseURL + API.ArtApiURL
            
        case "facebook;twitter":
            API.ArtApiURL = "/\(API.getArticleType)" + "/\(API.Section)" + "/\(API.AllSocial)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
            return API.BaseURL + API.ArtApiURL
            
        default:
            return "https://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/facebook;twitter/30.json?api-key=hg7IA4Gfku3AaaVwrA5hSEgfpF0AqAoi"
        }
    }
    
    // Color constants
    static let PrimaryTextColor       = UIColor.black
    static let SecondryTextColor      = UIColor.darkGray
    static let PrimaryBackGroundColor = UIColor.lightGray
    
}
