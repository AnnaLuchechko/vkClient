//
//  Group.swift
//  vkClient
//
//  Created by Anna Luchechko on 16.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
//   let group = try? newJSONDecoder().decode(Group.self, from: jsonData)

struct VkGroup: Codable {
    let response: Response
    
    struct Response: Codable {
        let count: Int
        let items: [Item]
    }

    struct Item: Codable {
        let id: Int
        let name, screenName: String
        let isClosed: Int
        let type: TypeEnum
        let isAdmin, isMember, isAdvertiser: Int?
        let photo50, photo100, photo200: String
        let deactivated: Deactivated?

        enum CodingKeys: String, CodingKey {
            case id, name
            case screenName = "screen_name"
            case isClosed = "is_closed"
            case type
            case isAdmin = "is_admin"
            case isMember = "is_member"
            case isAdvertiser = "is_advertiser"
            case photo50 = "photo_50"
            case photo100 = "photo_100"
            case photo200 = "photo_200"
            case deactivated
        }
    }

    enum Deactivated: String, Codable {
        case banned = "banned"
    }

    enum TypeEnum: String, Codable {
        case event = "event"
        case group = "group"
        case page = "page"
    }
    
}

