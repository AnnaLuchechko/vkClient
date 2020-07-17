//
//  CommunitiesTableViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 09.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CommunitiesTableViewController: UITableViewController {
            
    var communities = [
        "Forbes Club",
        "Banking & Insurance",
        "Wealth Management",
        "Бизнес",
        "Технологии",
        "Инновации",
        "Netflix",
        "Инвестидея",
        "Autonews",
        "Недвижимость",
        "Подкасты",
        "Crypto & Blockchain",
        "Education",
        "ForbesLife",
        "Forbes Travel Guide"
    ]
    
    var communitiesPhotos = [
        UIImage(named: "bezos"),
        UIImage(named: "gates"),
        UIImage(named: "arno"),
        UIImage(named: "buffett"),
        UIImage(named: "elison"),
        UIImage(named: "ortega"),
        UIImage(named: "cukerberg"),
        UIImage(named: "uolton"),
        UIImage(named: "uoltonw"),
        UIImage(named: "balmer"),
        UIImage(named: "slim"),
        UIImage(named: "peydj"),
        UIImage(named: "brin"),
        UIImage(named: "mayers"),
        UIImage(named: "bloomberg"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
    
    extension CommunitiesTableViewController {
        
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return communities.count
        }
        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }
            
            cell.titleLabel.text = communities[indexPath.row]
            cell.communityimage.image = communitiesPhotos[indexPath .row]
            
            print("Cell created for row: \(indexPath.row), \(communities[indexPath.row]), \(String(describing: communitiesPhotos[indexPath .row]))")
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if editingStyle == .delete {
                communities.remove(at: indexPath.row)
                
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        }

}
