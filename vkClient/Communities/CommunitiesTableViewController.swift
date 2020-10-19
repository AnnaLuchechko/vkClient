////
////  CommunitiesTableViewController.swift
////  vkClient
////
////  Created by Anna Luchechko on 09.07.2020.
////  Copyright © 2020 Anna Luchechko. All rights reserved.
////
//
//import UIKit
//
//class CommunitiesTableViewController: UITableViewController {
//    
//    var communities = [
//        Community("Forbes Club", UIImage(named: "forbesclub"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Netflix", UIImage(named: "N"), "Netflix - это потоковая служба, которая позволяет нашим членам смотреть самые разнообразные отмеченные наградами телешоу, фильмы, документальные фильмы и многое другое на тысячах подключенных к Интернету устройств . С Netflix вы можете наслаждаться неограниченным просмотром нашего контента без рекламы. Всегда есть что-то новое, и каждый месяц добавляются новые телешоу и фильмы!"),
//        Community("Autonews", UIImage(named: "auto"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Forbes Life", UIImage(named: "life"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Подкасты", UIImage(named: "podcast"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Crypto & Blockchain", UIImage(named: "crypto"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Education", UIImage(named: "education"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Banking & Insurance", UIImage(named: "banking"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Технологии", UIImage(named: "tech"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Wealth Management", UIImage(named: "wealth"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Бизнес", UIImage(named: "biznes"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Forbes Travel Guide", UIImage(named: "travel"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Недвижимость", UIImage(named: "nedv"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
//        Community("Инновации", UIImage(named: "innow"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов.")
//    ]
//    
//    private var filteredCommunities = [Community]()
//    private let searchController = UISearchController(searchResultsController: nil)
//    private var searchBarIsEmpty: Bool {
//        guard let text = searchController.searchBar.text else { return false }
//        return text.isEmpty
//    }
//    private var isFiltering: Bool {
//        return searchController.isActive && !searchBarIsEmpty
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        //Setup the Search Controller
//        searchController.searchBar.delegate = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        
//        tableView.tableHeaderView = searchController.searchBar
//        tableView.setContentOffset(CGPoint.init(x: 0, y: searchController.searchBar.frame.size.height), animated: false)
//    
//    }
//    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        
//        if segue.destination is CommunitiesGlobalSearchTableViewController {
//            let communitiesGlobalSearchTableViewController = segue.destination as? CommunitiesGlobalSearchTableViewController
//            communitiesGlobalSearchTableViewController?.userCommunities = communities
//        }
//    }
//            
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredCommunities.count
//        }
//        return communities.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }
//        
//        var community: Community
//        if isFiltering {
//            community = filteredCommunities[indexPath.row]
//        } else {
//            community = communities[indexPath.row]
//        }
//        
//        cell.titleLabel.text = community.communityName
//        cell.communityimage.image = community.communityImage
//        
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        
//        if editingStyle == .delete {
//            communities.remove(at: indexPath.row)
//            
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
//    
//}
//
//extension CommunitiesTableViewController: UISearchBarDelegate {
//    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        
//        filteredCommunities = communities.filter({ (community: Community) -> Bool in
//            return community.communityName.lowercased().contains(searchText.lowercased())
//        })
//
//        tableView.reloadData()
//    }
//    
//}
