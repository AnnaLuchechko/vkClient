//
//  GlobalGroupsController.swift
//  vkClient
//
//  Created by Anna Luchechko on 20.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit
import Kingfisher

class GlobalGroupsController: UITableViewController {

    var userCommunities = [Group.Item]()
    var globalCommunities = [Group.Item]()


    @IBAction func addCommunity(_ sender: Any) {
    }

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
        vkNetworkService.getGroups(url: vkNetworkService.getUrlForVKMethod(vkParameters: .searchGroups, userId: Session.shared.userID), completion: {
            groupModel, error in guard let groupModel = groupModel else {
                print(error)
                return
            }
            self.globalCommunities = groupModel.response.items
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }

        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        //  Filter globalCommunities by communities array to remove userCommunities
        globalCommunities = globalCommunities.filter({ item in userCommunities.contains(where: { $0.name == item.name }) })
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCommunities.count
        }
        return globalCommunities.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }

        var globalCommunity: Group.Item
        if isFiltering {
            globalCommunity = filteredCommunities[indexPath.row]
        } else {
            globalCommunity = globalCommunities[indexPath.row]
        }

        cell.titleLabel.text = globalCommunity.name
        cell.communityimage.kf.setImage(with: URL(string: globalCommunity.photo50 ))

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            globalCommunities.remove(at: indexPath.row)

            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension GlobalGroupsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredCommunities = globalCommunities.filter({ (community: Group.Item) -> Bool in
            return community.name.lowercased().contains(searchText.lowercased())
        })

        tableView.reloadData()
    }

}

