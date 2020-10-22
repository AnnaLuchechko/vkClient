//
//  VKRealmService.swift
//  vkClient
//
//  Created by Anna Luchechko on 22.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import RealmSwift

class VKRealmService {

    func saveUsersToRealm(userList: [UserRealm]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldFriendList = realm.objects(UserRealm.self) // список существующих записей
                realm.delete(oldFriendList) // удалить старые данные
                realm.add(userList) // записать новые данные
            }
        } catch {
            print(error)
        }
    }
    
    func deleteAllFromRealm() {
        do {
            let realm = try Realm()
            try realm.write{
                realm.deleteAll()
            }
        } catch {
            print(error)
        }
    }
    
}
