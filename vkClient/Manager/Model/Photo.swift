//
//  Photo.swift
//  vkClient
//
//  Created by Anna Luchechko on 16.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
//   let photo = try? newJSONDecoder().decode(Photo.self, from: jsonData)

struct Photo: Codable {
    let response: Response
}

struct Response: Codable {
    let count: Int
    let items: [Item]
}

struct Item: Codable {
    let albumID, date, id, ownerID: Int
    let hasTags: Bool
    let postID: Int?
    let sizes: [Size]
    let text: String

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case hasTags = "has_tags"
        case postID = "post_id"
        case sizes, text
    }
}

struct Size: Codable {
    let height: Int
    let url: String
    let type: TypeEnum
    let width: Int
}

enum TypeEnum: String, Codable {
    case m = "m"
    case o = "o"
    case p = "p"
    case q = "q"
    case r = "r"
    case s = "s"
    case w = "w"
    case x = "x"
    case y = "y"
    case z = "z"
}

