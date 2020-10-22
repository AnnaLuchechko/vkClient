//
//  UserRealm.swift
//  vkClient
//
//  Created by Anna Luchechko on 22.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

class UserRealm: Object {

    @objc dynamic var userId = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo50 = ""

    init(userId:String, firstName:String, lastName:String, photo50: String) {
        self.userId = userId
        self.firstName = firstName
        self.lastName = lastName
        self.photo50 = photo50
    }
    
    required override init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
}
