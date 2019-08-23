//
//  UserLocationModel.swift
//  AdvancedProject
//
//  Created by Лилия on 8/14/19.
//  Copyright © 2019 ITEA. All rights reserved.
//

import Foundation
import RealmSwift

class UserLocationModel: Object {
    
    @objc dynamic var longtitude = Double()
    @objc dynamic var latitude = Double()
}
