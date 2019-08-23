//
//  UserModel.swift
//  AdvancedProject
//
//  Created by Лилия on 8/14/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import RealmSwift

class UserModel: Object {
    
    @objc dynamic var token : String = ""
    
    @objc dynamic var email = String()
    @objc dynamic var password = String()
    @objc dynamic var name = String()
    @objc dynamic var surName = String()
    @objc dynamic var age = 0
    @objc dynamic var city = String()
    @objc dynamic var dayOfBirthday = String()
    @objc dynamic var phone = String()
    @objc dynamic var country = String()
    @objc dynamic var region = String()
    @objc dynamic var zip = String()
    @objc dynamic var location : UserLocationModel?
}

