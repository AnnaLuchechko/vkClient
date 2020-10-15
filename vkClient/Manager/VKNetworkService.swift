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
    
    // Custom session
    func getData(token:String, userID: Int, vkParameters: VKParameters) {
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/users.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.124"),
        ]
        
        // Build URL-parameters to get requested data
        switch vkParameters {
        case .friendsList:
            urlConstructor.path = "/method/friends.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(userID)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "fields", value: "photo_50"))
        case .userPhotos:
            urlConstructor.path = "/method/photos.getAll"
            urlConstructor.queryItems?.append(URLQueryItem(name: "owner_id", value: String(userID)))
        case .userGroups:
            urlConstructor.path = "/method/groups.get"
            urlConstructor.queryItems?.append(URLQueryItem(name: "user_id", value: String(userID)))
            urlConstructor.queryItems?.append(URLQueryItem(name: "extended", value: "1"))
        case .searchGroups:
            urlConstructor.path = "/method/groups.search"
            urlConstructor.queryItems?.append(URLQueryItem(name: "q", value: "video"))
            urlConstructor.queryItems?.append(URLQueryItem(name: "type", value: "group"))
        }
        
        // Check if URL is valid
        guard let url = urlConstructor.url else { return }
        
        //Run dataTask to get response from API
        let dataTask = session.dataTask(with: url) { (data, response, error) in
            if let data = data {
                if let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.allowFragments) {
                    print(json)
                }
            } else if let error = error {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }

}

