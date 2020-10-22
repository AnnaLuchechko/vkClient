//
//  GroupsController.swift
//  vkClient
//
//  Created by Anna Luchechko on 20.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.

import UIKit
import Kingfisher
import RealmSwift

class GroupsController: UITableViewController {
    
    private var communities = [GroupRealm]()
    var group: GroupRealm?

    private var filteredCommunities = [GroupRealm]()
    private let searchController = UISearchController(searchResultsController: nil)
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false }
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Setup the Search Controller
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        tableView.tableHeaderView = searchController.searchBar
        tableView.setContentOffset(CGPoint.init(x: 0, y: searchController.searchBar.frame.size.height), animated: false)
        
        reloadGroupsDataFromRealm()
        processGroupsResponse()
    }
    
    func reloadGroupsDataFromRealm() {
        DispatchQueue.main.async {
            self.communities = VKRealmService().getGroupsRealmData() ?? [GroupRealm]()
            guard self.communities.count != 0 else { return }
            self.tableView.reloadData()
        }
    }
    
    func processGroupsResponse() {
        let vkNetworkService = VKNetworkService()
        vkNetworkService.getGroups(url: vkNetworkService.getUrlForVKMethod(vkParameters: .userGroups, userId: Session.shared.userID), completion: {
            groupModel, error in guard groupModel != nil else {
                print(error)
                return
            }

            DispatchQueue.main.async {
                self.reloadGroupsDataFromRealm()
            }

        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.destination is GlobalGroupsController {
            let globalGroupsController = segue.destination as? GlobalGroupsController
            globalGroupsController?.userCommunities = communities
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCommunities.count
        }
        return communities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }

        var community: GroupRealm
        if isFiltering {
            community = filteredCommunities[indexPath.row]
        } else {
            community = communities[indexPath.row]
        }

        cell.titleLabel.text = community.name
        cell.communityimage.kf.setImage(with: URL(string: community.photo50 ))

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            communities.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension GroupsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredCommunities = communities.filter({ (community: GroupRealm) -> Bool in
            return community.name.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }

}