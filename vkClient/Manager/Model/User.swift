//
//  User.swift
//  vkClient
//
//  Created by Anna Luchechko on 16.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

struct User: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [Item]
}

struct Item: Codable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool?
    let photo50: String
    let trackCode: String
    let lists: [Int]?
    let deactivated: Deactivated?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case isClosed = "is_closed"
        case canAccessClosed = "can_access_closed"
        case photo50 = "photo_50"
        case trackCode = "track_code"
        case lists, deactivated
    }
}

enum Deactivated: String, Codable {
    case banned = "banned"
    case deleted = "deleted"
}

