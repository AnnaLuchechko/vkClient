//
//  LoginViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 14.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit
import WebKit

class VKLoginController: UIViewController {
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var components = URLComponents()
        components.scheme = "https"
        components.host = "oauth.vk.com"
        components.path = "/authorize"
        components.queryItems = [
            URLQueryItem(name: "client_id", value: "7627434"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.124")
        ]
        
        let request = URLRequest(url: components.url!)
        webView.load(request)
        
    }
}

extension VKLoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        print("logged")
        
        guard let url = navigationResponse.response.url,
            url.path == "/blank.html",
            let fragment = url.fragment else { decisionHandler(.allow); return }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        print(params)
        
        guard let token = params["access_token"],
            let userIdString = params["user_id"],
            let userID = Int(userIdString) else {
                decisionHandler(.allow)
                return
        }
        
        Session.shared.token = token
        Session.shared.userID = userID
        print(token, userID)
        
        let vkNetworkService = VKNetworkService()
        vkNetworkService.getFriends(url: vkNetworkService.getUrlForVKMethod(vkParameters: .friendsList), completion: {
            userModel, error in guard let userModel = userModel else {
                print(error)
                return
            }
            print(userModel.response.items[0].lastName)
        })
        
        vkNetworkService.getPhotos(url: vkNetworkService.getUrlForVKMethod(vkParameters: .userPhotos), completion: {
            photoModel, error in guard let photoModel = photoModel else {
                print(error)
                return
            }
            print(photoModel.response.items[0].ownerID)
        })
        
        vkNetworkService.getGroups(url: vkNetworkService.getUrlForVKMethod(vkParameters: .userGroups), completion: {
            groupModel, error in guard let groupModel = groupModel else {
                print(error)
                return
            }
            print(groupModel.response.items[0].name)
        })
        
        decisionHandler(.cancel)
        
    }
}

