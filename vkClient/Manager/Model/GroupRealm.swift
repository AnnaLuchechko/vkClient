//
//  GroupRealm.swift
//  vkClient
//
//  Created by Anna Luchechko on 22.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRealm: Object {

    @objc dynamic var id = 0
    @objc dynamic var name = ""
    @objc dynamic var photo50 = ""

    init(id:Int, name: String, photo50: String) {
        self.id = id
        self.name = name
        self.photo50 = photo50
    }
    
    required init() {
        super.init()
    }
    
}
