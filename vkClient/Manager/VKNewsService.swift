//
//  VKNewsService.swift
//  vkClient
//
//  Created by Anna Luchechko on 25.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

class VKNewsService {
    
    // Use DispatchGroup to parse newsfeed response
    let dispatchGroup = DispatchGroup()
    
    func getVKNewsFeed(completion: @escaping (NewsFeed?, String) -> Void) {
            
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/newsfeed.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.124"),
            URLQueryItem(name: "filters", value: "post,photo"),
            URLQueryItem(name: "count", value: "100")
        ]
        
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        guard let url = urlConstructor.url else { fatalError() }

        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("VKNewsService error: data nil")
                completion(nil, "data is nil")
                return
            }
            do {
                
                self.dispatchGroup.enter()
                
                let newsFeed = try JSONDecoder().decode(NewsFeed.self, from: data)
                // Create array of NewsFeedRealm objects to save the into Realm
                var newsList: [NewsFeedRealm] = []
                
                // for each element in array
                for news in newsFeed.response.items {
                    // only for photo or post types
                    
                    if (news.type == NewsFeed.PostTypeEnum.photo || news.type == NewsFeed.PostTypeEnum.post) {
                        
                        var srcName: String, srcPhotoUrl: String, pstPhotoUrl: String, pstTxt: String
                        
                        if (news.sourceID < 0) {
                            let group = newsFeed.response.groups.first(where: {$0.id == abs(news.sourceID)})
                            srcName = group?.name ?? "empty name"
                            srcPhotoUrl = group?.photo100 ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"
                        } else {
                            let profile = newsFeed.response.profiles.first(where: {$0.id == news.sourceID})
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
                    
                }
                
                self.dispatchGroup.leave()
                    
            // Catch errors on NewsFeed JSON decode
            } catch let DecodingError.dataCorrupted(context) {
                print(context)
                self.dispatchGroup.leave()
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.dispatchGroup.leave()
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.dispatchGroup.leave()
            } catch let DecodingError.typeMismatch(type, context)  {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
                self.dispatchGroup.leave()
            } catch {
                print("error: ", error)
                self.dispatchGroup.leave()
            }
            
        }
        task.resume()
    }
    
}
