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
        "Джефф Безос",
        "Билл Гейтс",
        "Бернар Арно",
        "Уоррен Баффет",
        "Ларри Эллисон",
        "Амансио Ортега",
        "Марк Цукерберг",
        "Джим Уолтон",
        "Элис Уолтон",
        "Роб Уолтон",
        "Стив Балмер",
        "Карлос Слим Элу",
        "Ларри Пейдж",
        "Сергей Брин",
        "Франсуаза Беттанкур-Майерс",
        "Майкл Блумберг",
        "Джек Ма",
        "Чарльз Кох",
        "Ма Хуатэн"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
}
    
    extension FriendsTableViewController {
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return friends.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as? FriendsCell else { fatalError() }
            
            cell.titleLabel.text = friends[indexPath.row]
            
            print("Cell created for row: \(indexPath.row), \(friends[indexPath.row])")
            
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
