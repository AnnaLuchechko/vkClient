//
//  UserPhotoView.swift
//  vkClient
//
//  Created by Anna Luchechko on 26.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

@IBDesignable class UserPhotoView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let shadowSubview = UIView()
        shadowSubview.frame.size = CGSize(width: 200, height: 200)
        shadowSubview.clipsToBounds = false
        shadowSubview.layer.shadowColor = UIColor.black.cgColor
        shadowSubview.layer.shadowOpacity = 0.9
        shadowSubview.layer.shadowOffset = CGSize.zero
        shadowSubview.layer.shadowRadius = 5.0
        
        let userPhoto = UIImageView(frame: shadowSubview.bounds)
        userPhoto.image = UIImage(named: "cars")
        userPhoto.layer.borderWidth = 1
        userPhoto.clipsToBounds = true
        userPhoto.layer.cornerRadius = 100
        
        shadowSubview.addSubview(userPhoto)
        
        addSubview(shadowSubview)
        

    }
    
}
