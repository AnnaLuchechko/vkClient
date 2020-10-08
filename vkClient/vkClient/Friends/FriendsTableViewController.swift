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
            Friend("Джефф", "Безос", ["bezos", "bezos2", "bezos3"]),
            Friend("Билл", "Гейтс", ["gates", "gates2", "gates3"]),
            Friend("Бернар", "Арно", ["arno", "arno2", "arno3"]),
            Friend("Уоррен", "Баффет", ["buffett", "buffet2", "buffet3"]),
            Friend("Ларри", "Эллисон", ["elison", "elison2", "elison3"]),
            Friend("Амансио", "Ортега", ["ortega", "ortega2", "ortega3"]),
            Friend("Марк", "Цукерберг", ["cukerberg", "cukerberg2", "cukerberg3"]),
            Friend("Джим", "Уолтон", ["uolton", "uolton2", "uolton3"]),
            Friend("Элис", "Уолтон", ["uoltonw", "uoltonw2", "uoltonw3"]),
            Friend("Стив", "Балмер", ["balmer", "balmer2", "balmer3"]),
            Friend("Карлос", "Слим Элу", ["slim", "slim2", "slim3"]),
            Friend("Ларри", "Пейдж", ["peydj", "peydj2", "peydj3"]),
            Friend("Сергей", "Брин", ["brin", "brin2", "brin3"]),
            Friend("Франсуаза", "Беттанкур-Майерс", ["mayers", "mayers2", "mayers3"]),
            Friend("Майкл", "Блумберг", ["bloomberg", "bloomberg2", "bloomberg3"]),
            Friend("Джек", "Ма", ["jackma", "jackma2", "jackma3"]),
            Friend("Чарльз", "Кох", ["koh", "koh2", "koh3"]),
            Friend("Ма", "Хуатэн", ["huaten", "huaten2", "huaten3"])
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
        cell.friendimage.image = UIImage(named: filteredFriend.friendsImage[0])
            
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
