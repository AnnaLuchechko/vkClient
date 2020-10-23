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

    @objc dynamic var groupId = ""
    @objc dynamic var name = ""
    @objc dynamic var photo50 = ""
    @objc dynamic var isMember = 0

    init(groupId: String, name: String, photo50: String, isMember: Int) {
        self.groupId = groupId
        self.name = name
        self.photo50 = photo50
        self.isMember = isMember
    }
    
    override required init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "groupId"
    }
    
}
