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
                let oldUserList = realm.objects(UserRealm.self) // список существующих записей
                realm.delete(oldUserList) // удалить старые данные
                realm.add(userList) // записать новые данные
            }
        } catch {
            print(error)
        }
    }
    
    func savePhotoToRealm(photoList: [PhotoRealm]) {
        do {
            let realm = try Realm()
            try realm.write{
                let oldPhotoList = realm.objects(PhotoRealm.self) // список существующих записей
                realm.delete(oldPhotoList) // удалить старые данные
                realm.add(photoList) // записать новые данные
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
