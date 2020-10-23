//
//  VKNetworkService.swift
//  vkClient
//
//  Created by Anna Luchechko on 15.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

class VKNetworkService {
    
    // List of request type to API
    enum VKParameters {
        case friendsList
        case userPhotos
        case userGroups
        case searchGroups
    }
    
    func getUrlForVKMethod(vkParameters: VKParameters, userId: Int) -> URL {
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/users.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: Session.shared.token),
            URLQueryItem(name: "v", value: "5.124"),
        ]
        
        // Build URL-parameters to get requested data
        switch vkParameters {
        case .friendsList:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .userPhotos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(userId)))
        case .userGroups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(userId)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "Google"))
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "h"))
        }
        guard let url = urlConstructor.url else { return URL(fileURLWithPath: "https://api.vk.com/blank.html") }
        return url
    }
    
    func getFriends(url:URL, completion: @escaping (User?, String) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        //Using shared(default) URLSession with no configuration
        //let task = URLSession.shared.dataTask(with: url) { data, response, error in

        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, "data is nil")
                return
            }
            do {
                let userModel = try JSONDecoder().decode(User.self, from: data)
                
                var userList: [UserRealm] = []
                for user in userModel.response.items {
                    userList.append(UserRealm(userId: String(user.id), firstName: user.firstName, lastName: user.lastName, photo50: user.photo50))
                }
                
                DispatchQueue.main.async {
                    let vkRealmService = VKRealmService()
                    vkRealmService.saveUsersToRealm(userList: userList)
                    completion(userModel, "")
                }
                
            } catch {
                completion(nil, "data decode error")
            }
        }
        task.resume()
    }
    
    func getPhotos(url:URL, completion: @escaping (Photo?, String) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        //Using shared(default) URLSession with no configuration
        //let task = URLSession.shared.dataTask(with: url) { data, response, error in

        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, "data is nil")
                return
            }
            do {
                let photoModel = try JSONDecoder().decode(Photo.self, from: data)
                
                var photosList: [PhotoRealm] = []
                for photo in photoModel.response.items {
                    photosList.append(PhotoRealm(photoId: String(photo.id), url: photo.sizes.last!.url, photoOwnerId: String(photo.ownerID)))
                }
                let vkRealmService = VKRealmService()
                DispatchQueue.main.async {
                    vkRealmService.savePhotosToRealm(photosList: photosList)
                    completion(photoModel, "")
                }
                
            } catch {
                completion(nil, "data decode error")
            }
        }
        task.resume()
    }
    
    func getGroups(url:URL, completion: @escaping (Group?, String) -> Void) {
        let configuration = URLSessionConfiguration.default
        let session = URLSession(configuration: configuration)
        
        //Using shared(default) URLSession with no configuration
        //let task = URLSession.shared.dataTask(with: url) { data, response, error in

        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil, "data is nil")
                return
            }
            do {
                let groupModel = try JSONDecoder().decode(Group.self, from: data)
                
                var groupsList: [GroupRealm] = []
                for group in groupModel.response.items {
                    groupsList.append(GroupRealm(groupId: String(group.id), name: group.name, photo50: group.photo50, isMember: group.isMember ?? 0))
                }
                let vkRealmService = VKRealmService()
                
                DispatchQueue.main.async {
                    vkRealmService.saveGroupsToRealm(groupsList: groupsList)
                    completion(groupModel, "")
                }
                
            } catch {
                completion(nil, "data decode error")
            }
        }
        task.resume()
    }

}

