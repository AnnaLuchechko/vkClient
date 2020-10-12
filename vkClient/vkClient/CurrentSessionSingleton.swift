//
//  CurrentSessionSingleton.swift
//  vkClient
//
//  Created by Anna Luchechko on 12.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CurrentSessionSingleton {
    
    private let userIDKey: String = "userID-vkClient-Key"
    
    var token: String = "Anna Luchechko"
    var userID: Int {
        set {
            UserDefaults.standard.set(newValue, forKey: userIDKey)
        }
        get {
            UserDefaults.standard.integer(forKey: userIDKey)
        }
    }
    
    static let shared = CurrentSessionSingleton()
    private init() {}
    
}
