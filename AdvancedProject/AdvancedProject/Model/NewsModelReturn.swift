//
//  NewsModelReturn.swift
//  AdvancedProject
//
//  Created by Лилия on 8/15/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import RealmSwift

class NewsModelReturn: Object {
    
    @objc dynamic var name = ""
    @objc dynamic var autor = ""
    @objc dynamic var title = ""
    @objc dynamic var newsDescription = ""
    @objc dynamic var urlToImage = ""
    
}
