//
//  News.swift
//  vkClient
//
//  Created by Anna Luchechko on 04.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

struct News {
    var newsType: NewsType
    
    var accountLabel: String
    var newsTime: String
    var accountImage: UIImage?
    var newsText: String
    var newsImage: UIImage?
    
    var newsLikeCount: String
    var newsCommentCount: String
    var newsRepostCount: String
    var newsViewCount: String
    
    enum NewsType {
        case Post, Photo
    }
    
    
    init(_ newsType: NewsType, _ accountLabel: String, _ newsTime: String, _ accountImage: UIImage?, _ newsText: String, _ newsImage: UIImage?, _ newsLikeCount: String, _ newsCommentCount: String, _ newsRepostCount: String, _ newsViewCount: String) {
        
        self.newsType = newsType
        
        self.accountLabel = accountLabel
        self.newsTime = newsTime
        self.accountImage = accountImage
        self.newsText = newsText
        self.newsImage = newsImage
        
        self.newsLikeCount = newsLikeCount
        self.newsCommentCount = newsCommentCount
        self.newsRepostCount = newsRepostCount
        self.newsViewCount = newsViewCount
    }
}
