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
    
    private var friends = [
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
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    var sections: [Character: [Friend]] = [:]
    var sectionTitles = [Character]()
    
    var filteredSections: [Character: [Friend]] = [:]
    var filteredSectionTitles = [Character]()


    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Setup the Search Controller
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.setContentOffset(CGPoint.init(x: 0, y: searchController.searchBar.frame.size.height), animated: false)
        
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
        if isFiltering {
            return filteredSections.count
        }
        return sections.count
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredSections[filteredSectionTitles[section]]?.count ?? 0
        }
        return sections[sectionTitles[section]]?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var sectionName = String(sectionTitles[section])
        
        if isFiltering {
            sectionName = String(filteredSectionTitles[section])
        }
        
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "friendSectionHeader") as? FriendsSectionHeaderView else { fatalError() }
        header.header.text = sectionName
        header.contentView.backgroundColor = tableView.backgroundColor
        header.contentView.layer.opacity = 0.5

        return header
    }
    
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        if isFiltering {
            return filteredSectionTitles.map{ String($0) }
        }
        return sectionTitles.map{ String($0) }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FriendsCell") as? FriendsCell else { fatalError() }
        
        var filteredFriend: Friend
        
        if isFiltering {
            guard let friend = filteredSections[filteredSectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
            filteredFriend = friend
        } else {
            guard let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
            filteredFriend = friend
        }
        
        
        //guard let friend = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
        
        cell.titleLabel.text = filteredFriend.friendsSurname + " " + filteredFriend.friendsName
        cell.friendimage.image = filteredFriend.friendsImage
            
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

extension FriendsTableViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSections = [:]
        filteredSectionTitles = [Character]()
        
        for friend in friends {
            let frindFullName = friend.friendsName + " " + friend.friendsSurname
            if(frindFullName.lowercased().contains(searchText.lowercased())) {
                let firstLetter = friend.friendsSurname.first!
                if filteredSections[firstLetter] != nil {
                    filteredSections[firstLetter]?.append(friend)
                }
                else {
                    filteredSections[firstLetter] = [friend]
                }
            }
        }
        filteredSectionTitles = Array(filteredSections.keys)
        filteredSectionTitles.sort()

        tableView.reloadData()
    }
    
}
