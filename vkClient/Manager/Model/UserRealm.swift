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

    @objc dynamic var id = 0
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var photo50 = ""

    init(id:Int, firstName:String, lastName:String, photo50: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photo50 = photo50
    }
    
    required init() {
        super.init()
    }
    
}
