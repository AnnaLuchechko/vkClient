//
//  FriendsPhotosCollectionViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 09.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsPhotosCollectionViewController: UICollectionViewController {
    
    var friendsPhotos = [
        FriendsPhoto("Джефф Безос", UIImage(named: "bezos")),
        FriendsPhoto("Билл Гейтс", UIImage(named: "gates")),
        FriendsPhoto("Бернар Арно", UIImage(named: "bezos")),
        FriendsPhoto("Уоррен Баффет", UIImage(named: "bezos")),
        FriendsPhoto("Ларри Эллисон", UIImage(named: "bezos")),
        FriendsPhoto("Амансио Ортега", UIImage(named: "bezos")),
        FriendsPhoto("Марк Цукерберг", UIImage(named: "bezos")),
        FriendsPhoto("Джим Уолтон", UIImage(named: "bezos")),
        FriendsPhoto("Элис Уолтон", UIImage(named: "bezos")),
        FriendsPhoto("Стив Балмер", UIImage(named: "bezos")),
        FriendsPhoto("Карлос Слим Элу", UIImage(named: "bezos")),
        FriendsPhoto("Ларри Пейдж", UIImage(named: "bezos")),
        FriendsPhoto("Сергей Брин", UIImage(named: "bezos")),
        FriendsPhoto("Франсуаза Беттанкур-Майерс", UIImage(named: "bezos")),
        FriendsPhoto("Майкл Блумберг", UIImage(named: "bezos")),
        FriendsPhoto("Джек Ма", UIImage(named: "bezos")),
        FriendsPhoto("Чарльз Кох", UIImage(named: "bezos")),
        FriendsPhoto("Ма Хуатэн", UIImage(named: "bezos"))
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension FriendsPhotosCollectionViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "friendsPhotoCell", for: indexPath) as? FriendsPhotoCell else { fatalError() }
                    
        cell.friendsName.text = friendsPhotos[indexPath.row].friendsName
        cell.friendsImage.image = friendsPhotos[indexPath.row].friendsImage

        return cell
    }
}
