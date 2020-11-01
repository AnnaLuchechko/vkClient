//
//  GlobalGroupsController.swift
//  vkClient
//
//  Created by Anna Luchechko on 20.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit
import Kingfisher
import RealmSwift

class GlobalGroupsController: UITableViewController {

    private var token: NotificationToken?
    var userCommunities: Results<GroupRealm>?
    private var globalCommunities: Results<GroupRealm>?
    private var filteredCommunities: Results<GroupRealm>?
    private var photoService: PhotoService?

    @IBAction func addCommunity(_ sender: Any) {}

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

        reloadGlobalGroupsDataFromRealm()
        VKOperationsService().getApiData(dataType: .searchGroups)
        addObserver()
    }
    
    func reloadGlobalGroupsDataFromRealm() {
        self.globalCommunities = VKRealmService().getGroupsRealmData(isMember: false)
        guard self.globalCommunities?.count != 0 else { return }
        self.tableView.reloadData()
    }
    
    func addObserver() {
        self.token = globalCommunities?.observe {(changes: RealmCollectionChange) in
            switch(changes) {
                case .initial:
                    self.reloadGlobalGroupsDataFromRealm()
                case .update(_, let deletions, let insertions, let modifications):
                    self.tableView.beginUpdates()
                    self.tableView.deleteRows(at: deletions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                    self.tableView.insertRows(at: insertions.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                    self.tableView.reloadRows(at: modifications.map{ IndexPath(row: $0, section: 0) }, with: .automatic)
                    self.tableView.endUpdates()
                case .error(_):
                    fatalError()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredCommunities?.count ?? 0
        }
        return globalCommunities?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }

        var globalCommunity: GroupRealm
        if isFiltering {
            globalCommunity = filteredCommunities![indexPath.row]
        } else {
            globalCommunity = globalCommunities![indexPath.row]
        }

        cell.titleLabel.text = globalCommunity.name
        cell.communityimage.image = photoService?.photo(atIndexpath: indexPath, byUrl: globalCommunity.photo50)

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        if editingStyle == .delete {
            //удаление row: нужно переделать логику(?)
            //globalCommunities?.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

extension GlobalGroupsController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        filteredCommunities = globalCommunities?.filter("name contains[c]%@", searchText)
        
        // тот же код для GroupRealm
        // filteredCommunities = globalCommunities.filter({ (community: GroupRealm) -> Bool in
        // return community.name.lowercased().contains(searchText.lowercased())
        // })
        
        tableView.reloadData()
    }

}

