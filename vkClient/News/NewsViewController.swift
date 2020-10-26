//
//  NewsViewController.swift
//  vkClient
//
//  Created by Anna Luchechko on 02.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit
import RealmSwift
import Kingfisher

class NewsViewController: UIViewController {
    @IBOutlet weak var newsTable: UITableView!
    
    private var newsFeed: Results<NewsFeedRealm>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsTable.delegate = self
        newsTable.dataSource = self
        
        loadNewsFeedFromRealm()
        
        let newsService = VKNewsService()
        newsService.getVKNewsFeed(completion: { newsFeedResponse, error in
            self.loadNewsFeedFromRealm()
        })
    }
    
    func loadNewsFeedFromRealm() {
        self.newsFeed = VKRealmService().getNewsFeedData()
        guard self.newsFeed?.count != 0 else { return }
        self.newsTable.reloadData()
    }
    
    func viewsToK(viewsCount: Int) -> String {
        var views: String = ""
        if viewsCount > 999 {
            let viewsCountFloat = Float(viewsCount)/1000.0
            views = String(format: "%.1fK", viewsCountFloat)
        } else {
            views = String(viewsCount)
        }
        return views
    }
    
}

extension NewsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsFeed?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (newsFeed?[indexPath.row].postType == "post") {
            guard let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsPost") as? NewsPost else { fatalError() }

            cell.accountLabel.text = newsFeed?[indexPath.row].sourceName
            
            // Format time to XX Jan XX:XX
            let dateFormatter = DateFormatter()
            // Parse date from Unix TimeStamp
            let date = Date(timeIntervalSince1970: TimeInterval(newsFeed?[indexPath.row].postTime ?? 1602054090))
            dateFormatter.dateFormat = "dd MMM hh:mm"
            cell.newsTime.text = dateFormatter.string(from: date)
            
            cell.accountImage.kf.setImage(with: URL(string: newsFeed?[indexPath.row].sourcePhotoUrl ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"))
            cell.newsText.text = newsFeed?[indexPath.row].postText
            cell.newsImage.kf.setImage(with: URL(string: newsFeed?[indexPath.row].postPhotoUrl ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"))
            
            cell.likeControl.likeCountLabel.text = String(newsFeed?[indexPath.row].postLikes ?? 0)
            cell.commentControl.commentCountLabel.text = String(newsFeed?[indexPath.row].postComments ?? 0)
            cell.shareControl.shareCountLabel.text = String(newsFeed?[indexPath.row].postReposts ?? 0)
            cell.viewControl.viewCountLabel.text = self.viewsToK(viewsCount: newsFeed?[indexPath.row].postViews ?? 0)

            return cell

        } else {
            guard let cell = newsTable.dequeueReusableCell(withIdentifier: "NewsPhoto") as? NewsPhoto else { fatalError() }
            
            cell.accountLabel.text = newsFeed?[indexPath.row].sourceName
            let dateFormatter = DateFormatter()
            let date = Date(timeIntervalSince1970: TimeInterval(newsFeed?[indexPath.row].postTime ?? 1602054090))
            dateFormatter.dateFormat = "dd MMM hh:mm"
            cell.newsTime.text = dateFormatter.string(from: date)
            cell.accountImage.kf.setImage(with: URL(string: newsFeed?[indexPath.row].sourcePhotoUrl ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"))
            cell.newsImage.kf.setImage(with: URL(string: newsFeed?[indexPath.row].postPhotoUrl ?? "https://www.meme-arsenal.com/memes/d9f5610c69e8da2698454b336a70536b.jpg"))
            
            cell.likeControl.likeCountLabel.text = String(newsFeed?[indexPath.row].postLikes ?? 0)
            cell.commentControl.commentCountLabel.text = String(newsFeed?[indexPath.row].postComments ?? 0)
            cell.shareControl.shareCountLabel.text = String(newsFeed?[indexPath.row].postReposts ?? 0)
            cell.viewControl.viewCountLabel.text = self.viewsToK(viewsCount: newsFeed?[indexPath.row].postViews ?? 0)
            
            return cell
        }

    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

