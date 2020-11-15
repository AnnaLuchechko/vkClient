//
//  FriendsAdapter.swift
//  vkClient
//
//  Created by Anna Luchechko on 12.11.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

final class GroupsAdapter {
    
    private let groupsTokenKey = "groups"
    private let realmService = VKRealmService()
    
    private var realmNotificationTokens: [String: NotificationToken] = [:]
    
    func getGroups(completion: @escaping ([Group]) -> Void) {
        guard let groupsRealm = realmService.getGroupsRealmData(isMember: true) else { return }
        
        self.realmNotificationTokens[groupsTokenKey]?.invalidate()
        
        let token = groupsRealm.observe { [weak self] (changes: RealmCollectionChange) in
            guard let self = self else { return }
            
            switch changes {
                case .update(let groupsRealm, _, _, _):
                    let groups = self.realmGroupToGroup(from: groupsRealm)
                    self.realmNotificationTokens[self.groupsTokenKey]?.invalidate()
                    completion(groups)
                case .error(let error):
                    fatalError("\(error)")
                case .initial(let groupsRealm):
                    let groups = self.realmGroupToGroup(from: groupsRealm)
                    self.realmNotificationTokens[self.groupsTokenKey]?.invalidate()
                    completion(groups)
            }
        }
        self.realmNotificationTokens[groupsTokenKey] = token
        AlamofireService.instance.getGroups(delegate: self)
    }
    
    func realmGroupToGroup(from groupsRealm: Results<GroupRealm>) -> [Group] {
        var groups: [Group] = []
        for groupRealm in groupsRealm {
            groups.append(self.user(from: groupRealm))
        }
        return groups
    }
    
    private func user(from groupRealm: GroupRealm) -> Group {
        return Group(groupId: groupRealm.groupId, name: groupRealm.name, photo50: groupRealm.photo50, isMember: true)
    }
    
}

extension GroupsAdapter: VkApiGroupsDelegate {
    
    func returnGroups(_ groups: [GroupRealm]) { }
    
}
