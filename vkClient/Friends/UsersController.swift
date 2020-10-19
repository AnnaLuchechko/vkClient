//
//  UsersController.swift
//  vkClient
//
//  Created by Anna Luchechko on 19.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class UsersController: UITableViewController {

    var selectedUser: User.Item? //Create variable to send FriendsPhoto element of selected cell
    
    private var userModel = [User.Item]()

    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    var sections: [Character: [User.Item]] = [:]
    var sectionTitles = [Character]()

    var filteredSections: [Character: [User.Item]] = [:]
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
        
        processUsersResponse()
    }

    func processUsersResponse() {
        let vkNetworkService = VKNetworkService()
        vkNetworkService.getFriends(url: vkNetworkService.getUrlForVKMethod(vkParameters: .friendsList), completion: {
            userModel, error in guard let userModel = userModel else {
                print(error)
                return
            }
            self.userModel = userModel.response.items
            for user in userModel.response.items {
                let firstLetter = user.lastName.first ?? "_"

                if self.sections[firstLetter] != nil {
                    self.sections[firstLetter]?.append(user)
                }
                else {
                    self.sections[firstLetter] = [user]
                }
            }
            self.sectionTitles = Array(self.sections.keys)
            self.sectionTitles.sort()    //Sort section titles A-Z
        
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        //Send selectedFriend by seque to FriendsPhotosCollectionViewController
        if segue.destination is FriendsPhotosCollectionViewController {
            let friendsPhotosCollectionViewController = segue.destination as? FriendsPhotosCollectionViewController
            //friendsPhotosCollectionViewController?.friend = selectedUser
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

        var filteredUser: User.Item

        if isFiltering {
            guard let user = filteredSections[filteredSectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
            filteredUser = user
        } else {
            guard let user = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
            filteredUser = user
        }

        cell.titleLabel.text = filteredUser.lastName + " " + filteredUser.firstName
        cell.friendimage.kf.setImage(with: URL(string: filteredUser.photo50))

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
        guard let user = sections[sectionTitles[indexPath.section]]?[indexPath.row] else { fatalError() }
        selectedUser = user

        return indexPath
    }

}

extension UsersController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredSections = [:]
        filteredSectionTitles = [Character]()

        for user in userModel {
            let userFullName = user.firstName + " " + user.lastName
            if(userFullName.lowercased().contains(searchText.lowercased())) {
                let firstLetter = user.lastName.first!
                if filteredSections[firstLetter] != nil {
                    filteredSections[firstLetter]?.append(user)
                }
                else {
                    filteredSections[firstLetter] = [user]
                }
            }
        }
        filteredSectionTitles = Array(filteredSections.keys)
        filteredSectionTitles.sort()

        tableView.reloadData()
    }

}
