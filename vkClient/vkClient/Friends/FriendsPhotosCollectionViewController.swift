//
//  FriendsPhotosCollectionViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 09.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var friend: Friend?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsPhotoCell", for: indexPath) as? FriendsPhotoCell else { fatalError() }
                    
        cell.friendsName.text = (friend?.friendsName ?? "") + " " + (friend?.friendsSurname ?? "")
        cell.friendsImage.image = friend?.friendsImage

        return cell
    }
}
