//
//  FriendsTableViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 14.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
        
    var friends = [
            FriendsPhoto("Джефф Безос", UIImage(named: "bezos")),
            FriendsPhoto("Билл Гейтс", UIImage(named: "gates")),
            FriendsPhoto("Бернар Арно", UIImage(named: "arno")),
            FriendsPhoto("Уоррен Баффет", UIImage(named: "buffett")),
            FriendsPhoto("Ларри Эллисон", UIImage(named: "elison")),
            FriendsPhoto("Амансио Ортега", UIImage(named: "ortega")),
            FriendsPhoto("Марк Цукерберг", UIImage(named: "cukerberg")),
            FriendsPhoto("Джим Уолтон", UIImage(named: "uolton")),
            FriendsPhoto("Элис Уолтон", UIImage(named: "uoltonw")),
            FriendsPhoto("Стив Балмер", UIImage(named: "balmer")),
            FriendsPhoto("Карлос Слим Элу", UIImage(named: "slim")),
            FriendsPhoto("Ларри Пейдж", UIImage(named: "peydj")),
            FriendsPhoto("Сергей Брин", UIImage(named: "brin")),
            FriendsPhoto("Франсуаза Беттанкур-Майерс", UIImage(named: "mayers")),
            FriendsPhoto("Майкл Блумберг", UIImage(named: "bloomberg")),
            FriendsPhoto("Джек Ма", UIImage(named: "jackma")),
            FriendsPhoto("Чарльз Кох", UIImage(named: "koh")),
            FriendsPhoto("Ма Хуатэн", UIImage(named: "huaten"))
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
    
    extension FriendsTableViewController {
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return friends.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as? FriendsCell else { fatalError() }
            
            cell.titleLabel.text = friends[indexPath.row].friendsName
            cell.friendimage.image = friends[indexPath.row].friendsImage
            
            print("Cell created for row: \(indexPath.row), \(friends[indexPath.row]), \(String(describing: friends[indexPath .row]))")
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                friends.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }
        
    }

    extension FriendsTableViewController {
        
    }
