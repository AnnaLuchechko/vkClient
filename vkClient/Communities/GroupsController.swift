//
//  GroupsController.swift
//  vkClient
//
//  Created by Anna Luchechko on 20.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.

import UIKit
import Kingfisher

class GroupsController: UITableViewController {
    
    private var communities = [Group.Item]()
    var group: Group.Item?

    private var filteredCommunities = [Group.Item]()
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
        
        processGroupsResponse()
    }
    
    func processGroupsResponse() {
        let vkNetworkService = VKNetworkService()
        vkNetworkService.getGroups(url: vkNetworkService.getUrlForVKMethod(vkParameters: .userGroups, userId: Session.shared.userID), completion: {
            groupModel, error in guard let groupModel = groupModel else {
                print(error)
                return
            }
            print(groupModel.response.items[0].name)
            self.communities = groupModel.response.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        })
    }

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.destination is CommunitiesGlobalSearchTableViewController {
//            let communitiesGlobalSearchTableViewController = segue.destination as? CommunitiesGlobalSearchTableViewController
//            communitiesGlobalSearchTableViewController?.userCommunities = communities
//        }
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCommunities.count
        }
        return communities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }

        var community: Group.Item
        if isFiltering {
            community = filteredCommunities[indexPath.row]
        } else {
            community = communities[indexPath.row]
        }

        cell.titleLabel.text = community.name
        cell.communityimage.kf.setImage(with: URL(string: communities[indexPath.row].photo50 ))

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

        filteredCommunities = communities.filter({ (community: Group.Item) -> Bool in
            return community.name.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }

}
