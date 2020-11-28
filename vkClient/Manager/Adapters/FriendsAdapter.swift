//
//  FriendsAdapter.swift
//  vkClient
//
//  Created by Anna Luchechko on 12.11.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

final class FriendsAdapter {
    
    private let friendsTokenKey = "friends"
    private let realmService = VKRealmService()
    
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    func getFriends(completion: @escaping ([User]) -> Void) {
        guard let usersRealm = realmService.getUsersRealmData() else { return }
        
        self.realmNotificationTokens[friendsTokenKey]?.invalidate()
        
        let token = usersRealm.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            
            switch changes {
                case .update(let realmUsers, _, _, _):
                    let users = self.realmUserToUser(from: realmUsers)
                    self.realmNotificationTokens[self.friendsTokenKey]?.invalidate()
                    completion(users)
                case .error(let error):
                    fatalError("\(error)")
                case .initial(let realmUsers):
                    let users = self.realmUserToUser(from: realmUsers)
                    self.realmNotificationTokens[self.friendsTokenKey]?.invalidate()
                    completion(users)
            }
        }
        self.realmNotificationTokens[friendsTokenKey] = token
        AlamofireService.instance.getFriends(delegate: self)
    }
    
    func realmUserToUser(from rlmUsers: Results<UserRealm>) -> [User] {
        var users: [User] = []
        for realmUser in rlmUsers {
            users.append(self.user(from: realmUser))
        }
        return users
    }
    
    private func user(from rlmUser: UserRealm) -> User {
        return User(userId: rlmUser.userId, firstName: rlmUser.firstName, lastName: rlmUser.lastName, photo50: rlmUser.photo50)
    }
    
}

extension FriendsAdapter: VkApiFriendsDelegate {
    
    func returnFriends(_ friends: [UserRealm]) { }
    
}
