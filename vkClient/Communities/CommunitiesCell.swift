//
//  CommunitiesCell.swift
//  vkClient
//
//  Created by Anna Luchechko on 17.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CommunitiesCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var containerCommunityImage: UIView!
    @IBOutlet weak var communityimage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        containerCommunityImage.layer.shadowColor = UIColor.black.cgColor
        containerCommunityImage.layer.cornerRadius = containerCommunityImage.bounds.width / 2
        containerCommunityImage.layer.shadowRadius = 10
        containerCommunityImage.layer.shadowOpacity = 0.5
        containerCommunityImage.layer.shadowOffset = .zero
        containerCommunityImage.layer.shadowPath = UIBezierPath(ovalIn: containerCommunityImage.bounds).cgPath
        
        communityimage.layer.cornerRadius = containerCommunityImage.bounds.width / 2
        communityimage.clipsToBounds = true
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onFriendImageTap(_:)))
        containerCommunityImage.addGestureRecognizer(gesture)
    }
    
    @objc func onFriendImageTap(_ gesture: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.3, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [], animations: {
            self.containerCommunityImage.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
        }, completion: { result in
            UIView.animate(withDuration: 0.2, animations: {
                self.containerCommunityImage.transform = CGAffineTransform.identity
           })
        })
    }
    
}
