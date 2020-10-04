//
//  NewsCell.swift
//  vkClient
//
//  Created by Anna Luchechko on 03.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

class NewsCell: UITableViewCell {
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var newsTime: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var containerAccountImage: UIView!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var controlView: UIView!
    
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
        
    }
}
