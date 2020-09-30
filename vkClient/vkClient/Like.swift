//
//  Like.swift
//  vkClient
//
//  Created by Anna Luchechko on 30.09.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class Like: UIView {
    
    private var like = UIImageView()
    private var likeCount = UILabel()

    private var likeImage = UIImage(named: "likeUnfilled")
    private var likes = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        self.frame.size = CGSize(width: 150, height: 45)
        
        like.frame.size = CGSize(width: 30, height: 30)
        like.image = likeImage
        
        likeCount.frame.size = CGSize(width: 50, height: 30)
        likeCount.frame.origin.x = like.frame.size.width + 10
        likeCount.text = String(likes)
        likeCount.font = UIFont(name: "Roboto", size: 20)
        
        addSubview(like)
        addSubview(likeCount)
        configure()
    }
    
    func configure() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        recognizer.numberOfTapsRequired = 1
        addGestureRecognizer(recognizer)
    }
    
    @objc func onTap(_ sender:UITapGestureRecognizer) {
        if likes == 0 {
            likes = 1
            likeImage = UIImage(named: "likeFilled")
        } else {
            likes = 0
            likeImage = UIImage(named: "likeUnfilled")
        }
        setNeedsDisplay()
    }
}
