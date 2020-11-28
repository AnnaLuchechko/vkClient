//
//  AlamofireService.swift
//  vkClient
//
//  Created by Anna Luchechko on 11.11.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import SwiftyJSON

protocol VkApiFriendsDelegate {
    
    func returnFriends(_ friends: [UserRealm])
}

protocol VkApiGroupsDelegate {
    
    func returnGroups(_ groups: [GroupRealm])
    
}

protocol VkApiPhotosDelegate {
    
    func returnPhotos(_ photos: [PhotoRealm])
    
}

protocol VkApiFeedsDelegate {
    
    func returnFeeds(_ feeds: [NewsFeedRealm])
    
}


class AlamofireService {
    
    private let vkApi = "https://api.vk.com/method/"
    static let instance = AlamofireService()
    private init(){}
    
    func getFriends(delegate: VkApiFriendsDelegate) {
        let method = "friends.get"
        let fullRow = "\(vkApi)\(method)"
        let params: Parameters = [
            "access_token": Session.shared.token,
            "fields": "photo_50",
            "v": "5.124",
        ]
        
        AF.request(fullRow, method: .get, parameters: params)
            .responseJSON(queue: DispatchQueue.global(qos: .userInteractive)) { response in
                
                let userModel = try! JSONDecoder().decode(VkUser.self, from: response.data!)
                var userList: [UserRealm] = []
                for user in userModel.response.items {
                    userList.append(UserRealm(userId: String(user.id), firstName: user.firstName, lastName: user.lastName, photo50: user.photo50))
                }
                
                DispatchQueue.main.async {
                    VKRealmService().saveUsersToRealm(userList: userList)
                    delegate.returnFriends(userList)
                }
        }
    }
    
    func getGroups(delegate: VkApiGroupsDelegate) {
        let method = "groups.get"
        let fullRow = "\(vkApi)\(method)"
        let params: Parameters = [
            "access_token": Session.shared.token,
            "user_id": Session.shared.userID,
            "extended": "1",
            "v": "5.124",
            "count":"100"
        ]
        
        AF.request(fullRow, method: .get, parameters: params)
            .responseJSON(queue: DispatchQueue.global(qos: .userInteractive)) { response in
                
                let groupModel = try! JSONDecoder().decode(VkGroup.self, from: response.data!)
                
                var groupsList: [GroupRealm] = []
                for group in groupModel.response.items {
                    groupsList.append(GroupRealm(groupId: String(group.id), name: group.name, photo50: group.photo50, isMember: group.isMember ?? 0))
                }
                
                DispatchQueue.main.async {
                    VKRealmService().saveGroupsToRealm(groupsList: groupsList)
                    delegate.returnGroups(groupsList)
                }
        }
    }

    func searchGroups(search: String, delegate: VkApiGroupsDelegate) {
        let method = "groups.search"
        let fullRow = "\(vkApi)\(method)"
        let params: Parameters = [
            "access_token": Session.shared.token,
            "q": search,
            "type": "h",
            "extended": "1",
            "v": "5.214"
        ]
        
        AF.request(fullRow, method: .get, parameters: params)
            .responseJSON(queue: DispatchQueue.global(qos: .userInteractive)) { response in
                
                let groupModel = try! JSONDecoder().decode(VkGroup.self, from: response.data!)
                
                var groupsList: [GroupRealm] = []
                for group in groupModel.response.items {
                    groupsList.append(GroupRealm(groupId: String(group.id), name: group.name, photo50: group.photo50, isMember: group.isMember ?? 0))
                }
                
                DispatchQueue.main.async {
                    VKRealmService().saveGroupsToRealm(groupsList: groupsList)
                    delegate.returnGroups(groupsList)
                }
        }
    }
    
    
    func getPhotos(delegate: VkApiPhotosDelegate) {
        let method = "photos.getAll"
        let fullRow = "\(vkApi)\(method)"
        
        let params: Parameters = [
            "access_token": Session.shared.token,
            "extended": "1",
            "v": "5.124",
            "count": "100"
        ]
        
        AF.request(fullRow, method: .get, parameters: params)
            .responseJSON(queue: DispatchQueue.global(qos: .userInteractive)) { response in
                
                let photoModel = try! JSONDecoder().decode(VkPhoto.self, from: response.data!)
                
                var photosList: [PhotoRealm] = []
                for photo in photoModel.response.items {
                    photosList.append(PhotoRealm(photoId: String(photo.id), url: photo.sizes.last!.url, photoOwnerId: String(photo.ownerID)))
                }
                
                DispatchQueue.main.async {
                    VKRealmService().savePhotosToRealm(photosList: photosList)
                    delegate.returnPhotos(photosList)
                }
        }
    }
    
    func getNews(delegate: VkApiFeedsDelegate) {
        let method = "newsfeed.get"
        let fullRow = "\(vkApi)\(method)"
        let params: Parameters = [
            "access_token": Session.shared.token,
            "filters": "post, photo",
            "v": "5.124",
            "count": "20"
        ]
        
        AF.request(fullRow, method: .get, parameters: params)
            .responseJSON(queue: DispatchQueue.global(qos: .userInteractive)) { response in
                
                let json = JSON(response.data!)
                
                var items = [VkNewsFeed.ResponseItem]()
                var groups = [VkNewsFeed.Group]()
                var profiles = [VkNewsFeed.Profile]()
                
                items = try! JSONDecoder().decode([VkNewsFeed.ResponseItem].self, from: json["response"]["items"].rawData())
                
                groups = try! JSONDecoder().decode([VkNewsFeed.Group].self, from: json["response"]["groups"].rawData())
                
                profiles = try! JSONDecoder().decode([VkNewsFeed.Profile].self, from: json["response"]["profiles"].rawData())
                
                let newsFeed = VkNewsFeed.Response(items: items, profiles: profiles, groups: groups, nextFrom: "")
                
                DispatchQueue.main.async {
                    let newsFeedRealm = self.newsFeedToRealm(newsFeed: newsFeed)
                    delegate.returnFeeds(newsFeedRealm)
                }
        }
    }
    
    func newsFeedToRealm(newsFeed: VkNewsFeed.Response) -> [NewsFeedRealm] {
        var newsList: [NewsFeedRealm] = []
        // for each element in array
        for news in newsFeed.items {
            // only for photo or post types
            if (news.type == VkNewsFeed.PostTypeEnum.photo || news.type == VkNewsFeed.PostTypeEnum.post) {
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
                
                if (news.type == VkNewsFeed.PostTypeEnum.photo) {
                    pstPhotoUrl = news.photos?.items.last?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                } else {
                    if (news.attachments?.last?.type == VkNewsFeed.AttachmentType.photo) {
                        pstPhotoUrl = news.attachments?.last?.photo?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                    } else if (news.attachments?.last?.type == VkNewsFeed.AttachmentType.link) {
                        pstPhotoUrl = news.attachments?.last?.link?.photo?.sizes.last?.url ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                    } else if (news.attachments?.last?.type == VkNewsFeed.AttachmentType.video) {
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

        DispatchQueue.main.async {
            VKRealmService().saveNewsFeedRealm(newsList: newsList)
        }
        return newsList
    }
    
}

