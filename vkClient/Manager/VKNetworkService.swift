//
//  VKNetworkService.swift
//  vkClient
//
//  Created by Anna Luchechko on 15.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation

class VKNetworkService {
    
    func getData(token:String, userID: Int) {
        // Custom session
        let configuration = URLSessionConfiguration.default
        let session =  URLSession(configuration: configuration)
        
        var urlConstructor = URLComponents()
        urlConstructor.scheme = "https"
        urlConstructor.host = "api.vk.com"
        urlConstructor.path = "/method/users.get"
        urlConstructor.queryItems = [
            URLQueryItem(name: "user_ids", value: String(userID)),
            URLQueryItem(name: "fields", value: "bdate"),
            URLQueryItem(name: "access_token", value: token),
            URLQueryItem(name: "v", value: "5.124"),
        ]
        
        guard let url = urlConstructor.url else { return }
        
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

