//
//  Like.swift
//  vkClient
//
//  Created by Anna Luchechko on 30.09.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class LikeControl: UIControl {
    
    private var likeCount: Int = 0

    private  let likeCountLabel = UILabel()
    private  let likeImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    private func updatelike() {
        if isSelected {
            likeImageView.image = UIImage(named: "likeFilled")
            likeCount = 1
        }
        else {
            likeImageView.image = UIImage(named: "likeUnfilled")
            likeCount = 0
        }
        likeCountLabel.text = "\(likeCount)"
    }

    @objc func onLikeTapped(_ gesture: UITapGestureRecognizer) {
        isSelected = !isSelected
        updatelike()
        sendActions(for: .valueChanged)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        likeImageView.frame.size = CGSize(width: 30, height: 30)
        addSubview(likeImageView)
        
        likeCountLabel.frame.size = CGSize(width: 60, height: 30)
        likeCountLabel.text = String(likeCount)
        likeCountLabel.font = UIFont(name: "Roboto", size: 20)
        likeCountLabel.frame.origin.x = likeImageView.frame.size.width + 7
        addSubview(likeCountLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped(_:)))
        self.addGestureRecognizer(gesture)
        updatelike()
    }
}
