//
//  Session.swift
//  vkClient
//
//  Created by Anna Luchechko on 12.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class Session {
        
    var token: String = " "
    var userID: Int = 0
    
    static let shared = Session()
    private init() {}
    
}

