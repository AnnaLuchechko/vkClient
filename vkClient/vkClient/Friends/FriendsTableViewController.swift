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
            Friend("Джефф", "Безос", UIImage(named: "bezos")),
            Friend("Билл", "Гейтс", UIImage(named: "gates")),
            Friend("Бернар", "Арно", UIImage(named: "arno")),
            Friend("Уоррен", "Баффет", UIImage(named: "buffett")),
            Friend("Ларри", "Эллисон", UIImage(named: "elison")),
            Friend("Амансио", "Ортега", UIImage(named: "ortega")),
            Friend("Марк", "Цукерберг", UIImage(named: "cukerberg")),
            Friend("Джим", "Уолтон", UIImage(named: "uolton")),
            Friend("Элис", "Уолтон", UIImage(named: "uoltonw")),
            Friend("Стив", "Балмер", UIImage(named: "balmer")),
            Friend("Карлос", "Слим Элу", UIImage(named: "slim")),
            Friend("Ларри", "Пейдж", UIImage(named: "peydj")),
            Friend("Сергей", "Брин", UIImage(named: "brin")),
            Friend("Франсуаза", "Беттанкур-Майерс", UIImage(named: "mayers")),
            Friend("Майкл", "Блумберг", UIImage(named: "bloomberg")),
            Friend("Джек", "Ма", UIImage(named: "jackma")),
            Friend("Чарльз", "Кох", UIImage(named: "koh")),
            Friend("Ма", "Хуатэн", UIImage(named: "huaten"))
        ]
    
    var sections: [Character: [Friend]] = [:]
    var sectionTitles = [Character]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Register .xib for section header
        tableView.register(UINib(nibName: "FriendsSectionHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "friendSectionHeader")
        tableView.estimatedSectionHeaderHeight = 40
        
        tableView.backgroundColor = UIColor(red: 0.29, green: 0.53, blue: 0.80, alpha: 1.00)
        
        
        for friend in friends {
            let firstLetter = friend.friendsSurname.first!
            
            if sections[firstLetter] != nil {
                sections[firstLetter]?.append(friend)
            }
            else {
                sections[firstLetter] = [friend]
            }
        }
        sectionTitles = Array(sections.keys)
        sectionTitles.sort()    //Sort section titles A-Z
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Send selectedFriend by seque to FriendsPhotosCollectionViewController
        if segue.destination is FriendsPhotosCollectionViewController {
            let friendsPhotosCollectionViewController = segue.destination as? FriendsPhotosCollectionViewController
            friendsPhotosCollectionViewController?.friend = selectedFriend
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[sectionTitles[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionName = String(sectionTitles[section])
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendSectionHeader") as? FriendsSectionHeaderView else { fatalError() }
        header.header.text = sectionName
        header.contentView.backgroundColor = tableView.backgroundColor
        header.contentView.layer.opacity = 0.5

        return header
    }
    
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sectionTitles.map{ String($0) }
    }
   
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return String(sectionTitles[section])
//    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as? FriendsCell else { fatalError() }
        guard let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
        
        cell.titleLabel.text = friend.friendsSurname + " " + friend.friendsName
        cell.friendimage.image = friend.friendsImage
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            sections[sectionTitles[indexPath.section]]?.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        //Store selectedFriend by indexPath  into variable
        guard let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
        selectedFriend = friend
        
        return indexPath
    }
    
}
