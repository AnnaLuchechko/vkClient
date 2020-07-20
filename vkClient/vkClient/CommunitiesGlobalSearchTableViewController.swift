//
//  CommunitiesGlobalSearchTableViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 09.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CommunitiesGlobalSearchTableViewController: UITableViewController {
    
    var userCommunities: [Community]?
        
    var globalCommunities = [
        Community("Forbes Top 200", UIImage(named: "top")),
        Community("Cars", UIImage(named: "cars")),
        Community("Lovely cats", UIImage(named: "cats")),
        Community("Netflix Best", UIImage(named: "NB")),
        Community("Education", UIImage(named: "education")),
        Community("Banking & Insurance", UIImage(named: "banking")),
        Community("Life", UIImage(named: "luxlife")),
        Community("Технологии", UIImage(named: "tech")),
        Community("Wealth Management", UIImage(named: "wealth")),
        Community("Бизнес", UIImage(named: "biznes")),
        Community("Forbes Travel Guide", UIImage(named: "travel")),
        Community("Недвижимость", UIImage(named: "nedv")),
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //  Filter globalCommunities by communities array to remove userCommunities
        globalCommunities = globalCommunities.filter({ item in !userCommunities!.contains(where: { $0.communityName == item.communityName }) })
    }
            
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return globalCommunities.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommunitiesCell") as? CommunitiesCell else { fatalError() }
        
        cell.titleLabel.text = globalCommunities[indexPath.row].communityName
        cell.communityimage.image = globalCommunities[indexPath.row].communityImage
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            globalCommunities.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

}

