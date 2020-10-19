//
//  UserPhotosController.swift
//  vkClient
//
//  Created by Anna Luchechko on 20.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UserPhotosController: UICollectionViewController {
    
    var user: User.Item?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsPhotoCell", for: indexPath) as? FriendsPhotoCell else { fatalError() }
                    
        cell.friendsName.text = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
        cell.friendsImage.kf.setImage(with: URL(string: user?.photo50 ?? "https://miro.medium.com/max/720/1*W35QUSvGpcLuxPo3SRTH4w.png"))

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Send selectedFriend's photos by seque to FriendsGalleryController
        if segue.destination is UserGalleryController {
            let friendsGalleryController = segue.destination as? UserGalleryController
            
            guard let userId = user?.id else { fatalError() }
            friendsGalleryController?.userId = userId
        }
    }
    
}

