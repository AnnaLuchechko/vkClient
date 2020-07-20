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
        Community("Forbes Club", UIImage(named: "forbesclub")),
        Community("Netflix", UIImage(named: "N")),
        Community("Autonews", UIImage(named: "auto")),
        Community("Forbes Life", UIImage(named: "life")),
        Community("Подкасты", UIImage(named: "podcast")),
        Community("Crypto & Blockchain", UIImage(named: "crypto")),
        Community("Education", UIImage(named: "education")),
        Community("Banking & Insurance", UIImage(named: "banking")),
        Community("Технологии", UIImage(named: "tech")),
        Community("Wealth Management", UIImage(named: "wealth")),
        Community("Бизнес", UIImage(named: "biznes")),
        Community("Forbes Travel Guide", UIImage(named: "travel")),
        Community("Недвижимость", UIImage(named: "nedv")),
        Community("Инновации", UIImage(named: "innow"))
    ]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.destination is CommunitiesGlobalSearchTableViewController {
            let communitiesGlobalSearchTableViewController = segue.destination as? CommunitiesGlobalSearchTableViewController
            communitiesGlobalSearchTableViewController?.userCommunities = communities
        }
    }
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return communities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }
        
        cell.titleLabel.text = communities[indexPath.row].communityName
        cell.communityimage.image = communities[indexPath.row].communityImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            communities.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}
