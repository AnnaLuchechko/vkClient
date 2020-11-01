//
//  NewsFeedRealm.swift
//  vkClient
//
//  Created by Anna Luchechko on 25.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

class NewsFeedRealm: Object {

    @objc dynamic var postId = 0
    @objc dynamic var sourceId = 0
    @objc dynamic var sourceName = ""
    @objc dynamic var sourcePhotoUrl = ""
    @objc dynamic var postType = ""
    
    @objc dynamic var postText = ""
    @objc dynamic var postLikes = 0
    @objc dynamic var postComments = 0
    @objc dynamic var postReposts = 0
    @objc dynamic var postViews = 0
    @objc dynamic var postPhotoUrl = ""
    @objc dynamic var postTime = 0

    init(postId: Int,
         sourceId: Int,
         sourceName: String,
         sourcePhotoUrl: String,
         postType: String,
         postText: String,
         postLikes: Int,
         postComments: Int,
         postReposts: Int,
         postViews: Int,
         postPhotoUrl: String,
         postTime: Int) {
        self.postId = postId
        self.sourceId = sourceId
        self.sourceName = sourceName
        self.sourcePhotoUrl = sourcePhotoUrl
        self.postType = postType
        self.postText = postText
        self.postLikes = postLikes
        self.postComments = postComments
        self.postReposts = postReposts
        self.postViews = postViews
        self.postText = postText
        self.postPhotoUrl = postPhotoUrl
        self.postTime = postTime
    }
    
    required override init() {
        super.init()
    }
    
    override static func primaryKey() -> String? {
        return "postId"
    }
    
}
