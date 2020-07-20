//
//  FriendsTableViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 14.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsTableViewController: UITableViewController {
        
    var selectedFriend: Friend? //Create variable to send FriendsPhoto element of selected cell
    
    var friends = [
            Friend("Джефф Безос", UIImage(named: "bezos")),
            Friend("Билл Гейтс", UIImage(named: "gates")),
            Friend("Бернар Арно", UIImage(named: "arno")),
            Friend("Уоррен Баффет", UIImage(named: "buffett")),
            Friend("Ларри Эллисон", UIImage(named: "elison")),
            Friend("Амансио Ортега", UIImage(named: "ortega")),
            Friend("Марк Цукерберг", UIImage(named: "cukerberg")),
            Friend("Джим Уолтон", UIImage(named: "uolton")),
            Friend("Элис Уолтон", UIImage(named: "uoltonw")),
            Friend("Стив Балмер", UIImage(named: "balmer")),
            Friend("Карлос Слим Элу", UIImage(named: "slim")),
            Friend("Ларри Пейдж", UIImage(named: "peydj")),
            Friend("Сергей Брин", UIImage(named: "brin")),
            Friend("Франсуаза Беттанкур-Майерс", UIImage(named: "mayers")),
            Friend("Майкл Блумберг", UIImage(named: "bloomberg")),
            Friend("Джек Ма", UIImage(named: "jackma")),
            Friend("Чарльз Кох", UIImage(named: "koh")),
            Friend("Ма Хуатэн", UIImage(named: "huaten"))
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Send selectedFriend by seque to FriendsPhotosCollectionViewController
        if segue.destination is FriendsPhotosCollectionViewController {
            let friendsPhotosCollectionViewController = segue.destination as? FriendsPhotosCollectionViewController
            friendsPhotosCollectionViewController?.friend = selectedFriend
        }
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as? FriendsCell else { fatalError() }
        
        cell.titleLabel.text = friends[indexPath.row].friendsName
        cell.friendimage.image = friends[indexPath.row].friendsImage
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            friends.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        //Store selectedFriend by indexPath  into variable
        selectedFriend = friends[indexPath.row]
        
        return indexPath
    }
    
}
