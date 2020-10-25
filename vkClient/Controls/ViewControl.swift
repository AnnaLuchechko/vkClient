//
//  ViewControl.swift
//  vkClient
//
//  Created by Anna Luchechko on 04.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class ViewControl: UIControl {
    
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
        var viewCount = Int(viewCountLabel.text!) ?? 0
        if isSelected {
            viewCount += 1
        }
        else {
            viewCount -= 1
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
        viewImageView.image = UIImage(named: "view")
        addSubview(viewImageView)
        
        viewCountLabel.frame.size = CGSize(width: 60, height: 30)
        viewCountLabel.font = UIFont(name: "Roboto", size: 20)
        viewCountLabel.frame.origin.x = viewImageView.frame.size.width + 3
        addSubview(viewCountLabel)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(onLikeTapped(_:)))
        self.addGestureRecognizer(gesture)
    }
}
