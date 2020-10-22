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

    @objc dynamic var photoId = ""
    @objc dynamic var photoOwnerId = ""
    @objc dynamic var url = ""

    init(photoId: String, url: String, photoOwnerId: String) {
        self.photoId = photoId
        self.photoOwnerId = photoOwnerId
        self.url = url
    }
    
    required override init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "photoId"
    }
    
}
