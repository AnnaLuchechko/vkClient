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
                realm.add(userList, update: .all) // записать новые данные
            }
            print("Database URL: /n", realm.configuration.fileURL!)
        } catch {
            print(error)
        }
    }
    
    func savePhotosToRealm(photosList: [PhotoRealm]) {
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(photosList, update: .all) // записать новые данные
            }
        } catch {
            print(error)
        }
    }
    
    func saveGroupsToRealm(groupsList: [GroupRealm]) {
        do {
            let realm = try Realm()
            try realm.write{
                realm.add(groupsList, update: .all) // записать новые данные
            }
        } catch {
            print(error)
        }
    }
    
    func getUsersRealmData() -> [UserRealm]? {
        do {
            let realm = try Realm()
            let usersFromRealm = realm.objects(UserRealm.self)
            return Array(usersFromRealm)
        } catch {
            print(error)
            return nil
        }
    }
    
    func getPhotosRealmData(ownerId: String) -> [PhotoRealm]? {
        do {
            let realm = try Realm()
            let photosFromRealm = realm.objects(PhotoRealm.self).filter("photoOwnerId == %@", ownerId)
            return Array(photosFromRealm)
        } catch {
            print(error)
            return nil
        }
    }
    
    func getGroupsRealmData() -> [GroupRealm]? {
        do {
            let realm = try Realm()
            let groupsFromRealm = realm.objects(GroupRealm.self)
            return Array(groupsFromRealm)
        } catch {
            print(error)
            return nil
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
