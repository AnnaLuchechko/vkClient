//
//  LikeControl.swift
//  vkClient
//
//  Created by Anna Luchechko on 30.09.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class LikeControl: UIControl {

    let likeCountLabel = UILabel()
    let likeImageView = UIImageView()
    
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
        var likesCount = Int(likeCountLabel.text!) ?? 0
        if isSelected {
            animateLikeTap()
            likesCount += 1
        }
        else {
            animateLikeTap()
            likesCount -= 1
        }
        likeCountLabel.text = "\(likesCount)"
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
        likeImageView.image = UIImage(named: "likeUnfilled")
        addSubview(likeImageView)
        
        likeCountLabel.frame.size = CGSize(width: 60, height: 30)
        likeCountLabel.font = UIFont(name: "Roboto", size: 20)
        likeCountLabel.frame.origin.x = likeImageView.frame.size.width + 7
        addSubview(likeCountLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped(_:)))
        self.addGestureRecognizer(gesture)
    }
}
