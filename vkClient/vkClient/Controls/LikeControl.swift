//
//  LikeControl.swift
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
    
    //called when initialized programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        config()
    }
    
    //called when initialized from storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        config()
    }

    private func updatelike() {
        if isSelected {
            animateLikeTap()
            likeCount = 1
        }
        else {
            animateLikeTap()
            likeCount = 0
        }
        likeCountLabel.text = "\(likeCount)"
    }

    @objc func onLikeTapped(_ gesture: UITapGestureRecognizer) {
        isSelected = !isSelected
        updatelike()
        sendActions(for: .valueChanged)
    }
    
    func animateLikeTap() {
        UIView.transition(with: likeImageView,
                        duration: 1,
                        options: self.isSelected ? .transitionFlipFromLeft : .transitionFlipFromRight,
                        animations: {
                          if self.isSelected {
                            self.likeImageView.image = UIImage(named: "likeFilled")
                          } else {
                            self.likeImageView.image = UIImage(named: "likeUnfilled")
                          }
                        },
                        completion: nil)
      }
    
    private func config() {
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
