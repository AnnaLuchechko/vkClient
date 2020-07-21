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
        Community("Forbes Top 200", UIImage(named: "top"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Cars", UIImage(named: "cars"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Lovely cats", UIImage(named: "cats"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Netflix Best", UIImage(named: "NB"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Education", UIImage(named: "education"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Banking & Insurance", UIImage(named: "banking"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Life", UIImage(named: "luxlife"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Технологии", UIImage(named: "tech"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Wealth Management", UIImage(named: "wealth"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Бизнес", UIImage(named: "biznes"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Forbes Travel Guide", UIImage(named: "travel"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Недвижимость", UIImage(named: "nedv"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Forbes Club", UIImage(named: "forbesclub"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Netflix", UIImage(named: "N"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Autonews", UIImage(named: "auto"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Forbes Life", UIImage(named: "life"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Подкасты", UIImage(named: "podcast"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Crypto & Blockchain", UIImage(named: "crypto"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Education", UIImage(named: "education"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Banking & Insurance", UIImage(named: "banking"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Технологии", UIImage(named: "tech"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Wealth Management", UIImage(named: "wealth"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Бизнес", UIImage(named: "biznes"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Forbes Travel Guide", UIImage(named: "travel"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Недвижимость", UIImage(named: "nedv"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов."),
        Community("Инновации", UIImage(named: "innow"), "FORBES CLUB — это закрытые встречи с членами списка Forbes, представителями власти и деятелями культуры. Пресса на эти встречи не приглашается, что позволяет вести разговор откровенно, без обычных для официальных выступлений банальностей и общих слов.")
    ]
    
    @IBAction func addCommunity(_ sender: Any) {
      let alert = UIAlertController(title: "Add Community", message: nil, preferredStyle: .alert)
      alert.addTextField { (textField) in
        textField.placeholder = "Name"
      }
       
      let typeCommunitNameAction = UIAlertAction(title: "OK", style: .default) { [weak self, weak alert] (action) in
        guard let communityName = alert?.textFields?.first?.text else { return }
        self?.addCommunity(name: communityName)
      }
      alert.addAction(typeCommunitNameAction)
       
      present(alert, animated: true, completion: nil)
    }
     
    private func addCommunity(name: String) {
      guard !name.isEmpty else { return }
        globalCommunities.append(Community(name, nil, ""))
      self.tableView.reloadData()
    }
    
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

