//
//  NewsModel.swift
//  AdvancedProject
//
//  Created by Лилия on 8/14/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import ObjectMapper

class NewsModelArticle : Mappable {
    
    var title : String?
    var autor: String?
    var description : String?
    var urlToImage : String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        title               <- map["title"]
        autor               <- map["author"]
        description         <- map["description"]
        urlToImage          <- map["urlToImage"]
    }
}


class NewsModel : Mappable {
    
    var status : String?
    var totalResults : Int?
    
    var articles : [NewsModelArticle] = []
    
    required init?(map: Map) {
        do {
            self.status = try map.value("status")
        } catch {
            print("No Status Present")
        }
    }
    
    func mapping(map: Map) {
        status              <-  map["status"]
        totalResults        <-  map["totalResults"]
        articles            <-  map["articles"]
        
    }
    
}
