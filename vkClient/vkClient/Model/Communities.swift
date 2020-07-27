//
//  Communities.swift
//  vkClient
//
//  Created by Anna Luchechko on 21.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

struct Community {
    var communityName: String
    var communityImage: UIImage?
    var communityDescription: String
    
    init(_ communityName: String, _ communityImage: UIImage?, _ communityDescription: String) {
        self.communityName = communityName
        self.communityImage = communityImage
        self.communityDescription = communityDescription
    }
}
