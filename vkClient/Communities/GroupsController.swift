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
    
    //var group: GroupRealm?
    
    //private var token: NotificationToken?
//    private var communities: Results<GroupRealm>?
//    private var filteredCommunities: Results<GroupRealm>?
    
    private var communities: [Group]?
    private var filteredCommunities: [Group]?
    private let groupsAdapter = GroupsAdapter()
    private var photoService: PhotoService?
    
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
        
        photoService = PhotoService(container: self.tableView)

        //Setup the Search Controller
        searchController.searchBar.delegate = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"

        tableView.tableHeaderView = searchController.searchBar
        tableView.setContentOffset(CGPoint.init(x: 0, y: searchController.searchBar.frame.size.height), animated: false)
        
        //reloadGroupsDataFromRealm()
        //VKOperationsService().getApiData(dataType: .userGroups)
        //addObserver()
        
        groupsAdapter.getGroups(completion: { groups in
            self.communities = groups
            guard self.communities?.count != 0 else { return }
            self.tableView.reloadData()
        })
    }
    
//    func reloadGroupsDataFromRealm() {
//        self.communities = VKRealmService().getGroupsRealmData(isMember: true)
//        guard self.communities?.count != 0 else { return }
//        self.tableView.reloadData()
//    }
    
//    func addObserver() {
//        self.token = communities?.observe {(changes: RealmCollectionChange) in
//            switch(changes) {
//                case .initial:
//                    self.reloadGroupsDataFromRealm()
//                case .update(_, let deletions, let insertions, let modifications):
//                    self.tableView.beginUpdates()
//                    self.tableView.deleteRows(at: deletions.map{ IndexPath(row: $0, section: 0) }, with: .left)
//                    self.tableView.insertRows(at: insertions.map{ IndexPath(row: $0, section: 0) }, with: .right)
//                    self.tableView.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) }, with: .fade)
//                    self.tableView.endUpdates()
//                case .error(_):
//                    fatalError()
//            }
//        }
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCommunities?.count ?? 0
        }
        return communities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }

        var community: Group
        if isFiltering {
            community = filteredCommunities![indexPath.row]
        } else {
            community = communities![indexPath.row]
        }

        cell.titleLabel.text = community.name
        cell.communityimage.image = photoService?.photo(atIndexpath: indexPath, byUrl: community.photo50)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            //communities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension GroupsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredCommunities = communities?.filter { $0.name.contains(searchText) }
        //filteredCommunities = communities?.filter("name contains[c]%@", searchText)
        tableView.reloadData()
    }

}
