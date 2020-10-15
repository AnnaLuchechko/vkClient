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
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onFriendImageTap(_:)))
        containerFriendImage.addGestureRecognizer(gesture)
    }
    
    @objc func onFriendImageTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.containerFriendImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { result in
            UIView.animate(withDuration: 0.2, animations: {
                self.containerFriendImage.transform = CGAffineTransform.identity
           })
        })
    }
    
}
