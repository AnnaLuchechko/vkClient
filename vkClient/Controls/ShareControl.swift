//
//  ShareControl.swift
//  vkClient
//
//  Created by Anna Luchechko on 04.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class ShareControl: UIControl {
    
    let shareCountLabel = UILabel()
    private let shareImageView = UIImageView()
    
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

    private func updateShare() {
        var shareCount = Int(shareCountLabel.text ?? "0") ?? 0
        if isSelected {
            shareCount += 1
        }
        else {
            shareCount -= 1
        }
        shareCountLabel.text = "\(shareCount)"
    }

    @objc func onLikeTapped(_ gesture: UITapGestureRecognizer) {
        isSelected = !isSelected
        updateShare()
        sendActions(for: .valueChanged)
    }
    
    private func config() {
        shareImageView.frame.size = CGSize(width: 30, height: 30)
        shareImageView.image = UIImage(named: "share")
        addSubview(shareImageView)
        
        shareCountLabel.frame.size = CGSize(width: 60, height: 30)
        shareCountLabel.font = UIFont(name: "Roboto", size: 20)
        shareCountLabel.frame.origin.x = shareImageView.frame.size.width + 7
        addSubview(shareCountLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped(_:)))
        self.addGestureRecognizer(gesture)
        updateShare()
    }
}
