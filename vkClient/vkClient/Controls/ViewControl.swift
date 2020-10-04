//
//  ViewControl.swift
//  vkClient
//
//  Created by Anna Luchechko on 04.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class ViewControl: UIControl {
    
    private var viewCount: Int = 0

    let viewCountLabel = UILabel()
    let viewImageView = UIImageView()
    
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

    private func updateView() {
        if isSelected {
            viewImageView.image = UIImage(named: "view")
            viewCount = 1
        }
        else {
            viewImageView.image = UIImage(named: "view")
            viewCount = 0
        }
        viewCountLabel.text = "\(viewCount)"
    }

    @objc func onLikeTapped(_ gesture: UITapGestureRecognizer) {
        isSelected = !isSelected
        updateView()
        sendActions(for: .valueChanged)
    }
    
    private func config() {
        viewImageView.frame.size = CGSize(width: 30, height: 30)
        addSubview(viewImageView)
        
        viewCountLabel.frame.size = CGSize(width: 60, height: 30)
        viewCountLabel.text = String(viewCount)
        viewCountLabel.font = UIFont(name: "Roboto", size: 20)
        viewCountLabel.frame.origin.x = viewImageView.frame.size.width + 7
        addSubview(viewCountLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped(_:)))
        self.addGestureRecognizer(gesture)
        updateView()
    }
}
