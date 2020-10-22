//
//  PhotoRealm.swift
//  vkClient
//
//  Created by Anna Luchechko on 22.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoRealm: Object {

    @objc dynamic var id = 0
    @objc dynamic var url = ""

    init(id:Int, url: String) {
        self.id = id
        self.url = url
    }
    
    required init() {
        super.init()
    }
    
}
