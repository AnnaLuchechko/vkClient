//
//  NewsPost.swift
//  vkClient
//
//  Created by Anna Luchechko on 24.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

class NewsPost: UITableViewCell {
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var containerAccountImage: UIView!
    @IBOutlet weak var newsText: UITextView!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var controlView: UIView!
    
    let likeControl = LikeControl()
    let commentControl = CommentControl()
    let shareControl = ShareControl()
    let viewControl = ViewControl()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerAccountImage.layer.shadowColor = UIColor.black.cgColor
        containerAccountImage.layer.cornerRadius = containerAccountImage.bounds.width / 2
        containerAccountImage.layer.shadowRadius = 10
        containerAccountImage.layer.shadowOpacity = 0.5
        containerAccountImage.layer.shadowOffset = .zero
        containerAccountImage.layer.shadowPath = UIBezierPath(ovalIn: containerAccountImage.bounds).cgPath
        
        accountImage.layer.cornerRadius = containerAccountImage.bounds.width / 2
        accountImage.clipsToBounds = true
        
        newsText.isScrollEnabled = true
        newsText.isUserInteractionEnabled = true
        
        likeControl.frame = CGRect(x: 10, y: 5, width: 44, height: 44)
        controlView.addSubview(likeControl)
        
        commentControl.frame = CGRect(x: 94, y: 5, width: 44, height: 44)
        controlView.addSubview(commentControl)
        
        shareControl.frame = CGRect(x: 178, y: 5, width: 44, height: 44)
        controlView.addSubview(shareControl)
        
        viewControl.frame = CGRect(x: frame.size.width - 40, y: 5, width: 44, height: 44)
        controlView.addSubview(viewControl)
    }
}

