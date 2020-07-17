//
//  FriendsPhotoCell.swift
//  vkClient
//
//  Created by Anna Luchechko on 14.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsPhotoCell: UICollectionViewCell {
    @IBOutlet weak var friendsImage: UIImageView!
    @IBOutlet weak var friendsName: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
}
