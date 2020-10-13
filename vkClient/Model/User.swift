//
//  User.swift
//  vkClient
//
//  Created by Anna Luchechko on 21.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

struct User {
    var userName: String
    var userPhoto: UIImage?
    var userAge: Int
    var userCountry: String
    
    init(_ userName: String, _ userPhoto: UIImage?, _ userAge: Int, _ userCountry: String) {
        self.userName = userName
        self.userPhoto = userPhoto
        self.userAge = userAge
        self.userCountry = userCountry

    }
}
