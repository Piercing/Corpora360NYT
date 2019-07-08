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
    static var sourceType : String = ""
    static var periodType : Int    = 1
    
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
    
    static let APIKey    = "hg7IA4Gfku3AaaVwrA5hSEgfpF0AqAoi"
    static let Section   = "all-sections"
    static let Facebook  = "facebook"
    static let Twitter   = "twitter"
    static let AllSocial = "facebook;twitter"
    static let BaseURL   = URL(string: "https://api.nytimes.com/svc/mostpopular/v2/mostviewed/")!
    static var ArtApiURL = ""
    
    static var AuthenticatedBaseURL: URL {
        return BaseURL.appendingPathComponent(getSocilaPlatform(socilaPlatform: API.getSourceType))
    }
    
    static func getSocilaPlatform(socilaPlatform: String) -> String {
        
        switch Defaults.sourceType {
            
        case "facebook": API.ArtApiURL =
            "/\(API.getArticleType)"  + "/\(API.Section)" + "/\(API.Facebook)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
        return API.ArtApiURL
            
        case "twitter": API.ArtApiURL =
            "/\(API.getArticleType)"  + "/\(API.Section)" + "/\(API.Twitter)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
        return API.ArtApiURL
            
        case "facebook;twitter": API.ArtApiURL =
            "/\(API.getArticleType)"  + "/\(API.Section)" + "/\(API.AllSocial)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
        return API.ArtApiURL
            
        default:
            API.ArtApiURL = "\(API.getSourceType)"  + "/\(API.getArticleType)"  + "/\(API.Section)" + "/\(API.getPeriodType)" + ".json?api-key=\(API.APIKey)"
            print("URL API: \(API.ArtApiURL)")
            return "https://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/facebook;twitter/30.json?api-key=hg7IA4Gfku3AaaVwrA5hSEgfpF0AqAoi"
        }
        
        print("URL FINAL: \(API.AuthenticatedBaseURL)")
        
    }
    
    // Color constants
    static  let PrimaryTextColor = UIColor.black
    static  let SecondryTextColor = UIColor.darkGray
    static let PrimaryBackGroundColor = UIColor.lightGray
    
}

// // https://api.nytimes.com/svc/mostpopular/v2/mostshared/all-sections/facebook;twitter/30.json?api-key=hg7IA4Gfku3AaaVwrA5hSEgfpF0AqAoi
//    static let EmailedBaseURL = "http://api.nytimes.com/svc/mostpopular/v2/mostemailed/"
//    static let ViewedBaseURL  = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/"
//    static let SharedBaseURL  = "http://api.nytimes.com/svc/mostpopular/v2/mostshared/"
