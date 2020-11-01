//
//  CommentControl.swift
//  vkClient
//
//  Created by Anna Luchechko on 04.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class CommentControl: UIControl {
    
    let commentCountLabel = UILabel()
    private let commentImageView = UIImageView()
    
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

    private func updateComment() {
        var commentCount = Int(commentCountLabel.text!) ?? 0
        if isSelected {
            commentCount += 1
        }
        else {
            commentCount -= 1
        }
        commentCountLabel.text = "\(commentCount)"
    }

    @objc func onLikeTapped(_ gesture: UITapGestureRecognizer) {
        isSelected = !isSelected
        updateComment()
        sendActions(for: .valueChanged)
    }
    
    private func config() {
        commentImageView.frame.size = CGSize(width: 30, height: 30)
        commentImageView.image = UIImage(named: "comment")
        addSubview(commentImageView)
        
        commentCountLabel.frame.size = CGSize(width: 60, height: 30)
        commentCountLabel.font = UIFont(name: "Roboto", size: 20)
        commentCountLabel.frame.origin.x = commentImageView.frame.size.width + 7
        addSubview(commentCountLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped(_:)))
        self.addGestureRecognizer(gesture)
    }
}
