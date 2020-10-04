//
//  NewsViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 02.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class NewsViewController: UIViewController {
    @IBOutlet weak var newsTable: UITableView!
    
    private var newsArray = [
        News("Apple", "10 Oct 2020", UIImage(named: "apple"), "Кидайте в коментарии последнюю фотографию из вашей галереи", UIImage(named: "newsImage"), "823", "67", "12", "1023")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable.delegate = self
        newsTable.dataSource = self
    }
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsCell") as? NewsCell else { fatalError() }
        
        cell.accountLabel.text = newsArray[indexPath.row].accountLabel
        cell.newsTime.text = newsArray[indexPath.row].newsTime
        cell.accountImage.image = newsArray[indexPath.row].accountImage
        cell.newsText.text = newsArray[indexPath.row].newsText
        cell.newsImage.image = newsArray[indexPath.row].newsImage
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

