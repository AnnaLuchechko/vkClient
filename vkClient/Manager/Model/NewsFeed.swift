//
//  News.swift
//  vkClient
//
//  Created by Anna Luchechko on 12.11.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

struct NewsFeed {
    
    var postId: Int
    var sourceId: Int
    var sourceName: String
    var sourcePhotoUrl: String
    var postType: String
    
    var postText: String
    var postLikes: Int
    var postComments: Int
    var postReposts: Int
    var postViews: Int
    var postPhotoUrl: String
    var postTime: Int
    
}
