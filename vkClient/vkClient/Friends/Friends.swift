//
//  Friends.swift
//  vkClient
//
//  Created by Anna Luchechko on 14.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

struct Friend {
    var friendsName: String
    var friendsSurname: String
    var friendsImage: UIImage?
    
    init(_ friendsName: String, _ friendsSurname: String, _ friendsImage: UIImage?) {
        self.friendsName = friendsName
        self.friendsSurname = friendsSurname
        self.friendsImage = friendsImage
    }
}
