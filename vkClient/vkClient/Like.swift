//
//  Like.swift
//  vkClient
//
//  Created by Anna Luchechko on 30.09.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

@IBDesignable class Like: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.frame.size = CGSize(width: 150, height: 45)
        
        let like = UIImageView()
        like.image = UIImage(named: "likeUnfilled")
        
        let likeCount = UILabel()
        

        
        addSubview(like)
        addSubview(likeCount)

    }
}
