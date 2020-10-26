//
//  VKNewsService.swift
//  vkClient
//
//  Created by Anna Luchechko on 25.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class VKNewsService {
    
    func getVKNewsFeed(completion: @escaping (NewsFeed.Response?, String) -> Void) {
        
        let apiUrl = "https://api.vk.com/method/newsfeed.get"

        let params: Parameters = [
            "filters" : "post, photo",
            "count" : 100,
            "access_token" : Session.shared.token,
            "v" : "5.124"
        ]

        AF.request(apiUrl, method: .get, parameters: params).responseJSON(queue: .global(qos: .utility)) { response in
            switch response.result {
                case let .success(value):
                    let json = JSON(value)
                    
                    let dispatchGroup = DispatchGroup()
                    
                    var items = [NewsFeed.ResponseItem]()
                    var groups = [NewsFeed.Group]()
                    var profiles = [NewsFeed.Profile]()
                    
                    DispatchQueue.global().async(group: dispatchGroup) {
                        items = try! JSONDecoder().decode([NewsFeed.ResponseItem].self, from: json["response"]["items"].rawData())
                    }
                    
                    DispatchQueue.global().async(group: dispatchGroup) {
                        groups = try! JSONDecoder().decode([NewsFeed.Group].self, from: json["response"]["groups"].rawData())
                    }
                    
                    DispatchQueue.global().async(group: dispatchGroup) {
                        profiles = try! JSONDecoder().decode([NewsFeed.Profile].self, from: json["response"]["profiles"].rawData())
                    }
                    
                    dispatchGroup.notify(queue: DispatchQueue.main) {
                        let newsFeed = NewsFeed.Response(items: items, profiles: profiles, groups: groups, nextFrom: "")
                        self.newsFeedToRealm(newsFeed: newsFeed, completion: { completion(newsFeed, "") })
                    }
                    
                case let .failure(error):
                    completion(nil, error.errorDescription ?? "unknown error")
            }
        }

    }
    
    func newsFeedToRealm(newsFeed: NewsFeed.Response, completion: @escaping () -> Void) {
        var newsList: [NewsFeedRealm] = []
        // for each element in array
        for news in newsFeed.items {
            // only for photo or post types
            if (news.type == NewsFeed.PostTypeEnum.photo || news.type == NewsFeed.PostTypeEnum.post) {
                var srcName: String, srcPhotoUrl: String, pstPhotoUrl: String, pstTxt: String
                
                if (news.sourceID < 0) {
                    let group = newsFeed.groups.first(where: {$0.id == abs(news.sourceID)})
                    srcName = group?.name ?? "empty name"
                    srcPhotoUrl = group?.photo100 ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                } else {
                    let profile = newsFeed.profiles.first(where: {$0.id == news.sourceID})
                    let profileFirstName = profile?.firstName ?? "name"
                    let profileLastName = profile?.lastName ?? "surname"
                    srcName = profileFirstName + " " + profileLastName
                    srcPhotoUrl = profile?.photo100 ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                }
                
                if (news.type == NewsFeed.PostTypeEnum.photo) {
                    pstPhotoUrl = news.photos?.items.last?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                } else {
                    if (news.attachments?.last?.type == NewsFeed.AttachmentType.photo) {
                        pstPhotoUrl = news.attachments?.last?.photo?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                    } else if (news.attachments?.last?.type == NewsFeed.AttachmentType.link) {
                        pstPhotoUrl = news.attachments?.last?.link?.photo?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                    } else if (news.attachments?.last?.type == NewsFeed.AttachmentType.video) {
                        pstPhotoUrl = news.attachments?.last?.video?.image.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                    } else {
                        // if repost
                        pstPhotoUrl = news.copyHistory?.last?.attachments?.last?.photo?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                    }
                }
                
                if (news.text == nil || news.text == "") {
                    pstTxt = news.copyHistory?.last?.text ?? ""
                } else {
                    pstTxt = news.text ?? ""
                }
                
                // Create and append Realm NewsFeed object
                newsList.append(NewsFeedRealm(postId: news.postID, sourceId: news.sourceID, sourceName: srcName, sourcePhotoUrl: srcPhotoUrl, postType: news.postType?.rawValue ?? "photo", postText: pstTxt, postLikes: news.likes?.count ?? 0, postComments: news.comments?.count ?? 0, postReposts: news.reposts?.count ?? 0, postViews: news.views?.count ?? 0, postPhotoUrl: pstPhotoUrl, postTime: news.date))
            }
        }

        
        // Run asynchronous task on main thread
        DispatchQueue.main.async {
            let vkRealmService = VKRealmService()
            vkRealmService.saveNewsFeedRealm(newsList: newsList)
            completion()
        }
    }
    
}
