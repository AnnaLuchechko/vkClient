//
//  FriendsCell.swift
//  vkClient
//
//  Created by Anna Luchechko on 14.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerFriendImage: UIView!
    @IBOutlet weak var friendimage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerFriendImage.layer.shadowColor = UIColor.black.cgColor
        containerFriendImage.layer.cornerRadius = containerFriendImage.bounds.width / 2
        containerFriendImage.layer.shadowRadius = 10
        containerFriendImage.layer.shadowOpacity = 0.5
        containerFriendImage.layer.shadowOffset = .zero
        containerFriendImage.layer.shadowPath = UIBezierPath(ovalIn: containerFriendImage.bounds).cgPath
        
        friendimage.layer.cornerRadius = containerFriendImage.bounds.width / 2
        friendimage.clipsToBounds = true
    }
}
