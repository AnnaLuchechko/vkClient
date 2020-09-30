//
//  UserPhotoView.swift
//  vkClient
//
//  Created by Anna Luchechko on 26.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

@IBDesignable class UserPhotoView: UIView {
    
    var userPhoto = UIImageView()
    var image = UIImage(named: "cars")
        
    @IBInspectable var shadowRadius: CGFloat = 5.0 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var shadowOpacity: Float = 0.9 {
        didSet {
            setNeedsDisplay()
        }
    }

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let shadowSubview = UIView()
        shadowSubview.frame.size = CGSize(width: 40, height: 40)
        shadowSubview.clipsToBounds = false
        shadowSubview.layer.shadowColor = shadowColor.cgColor
        shadowSubview.layer.shadowOpacity = shadowOpacity
        shadowSubview.layer.shadowOffset = CGSize.zero
        shadowSubview.layer.shadowRadius = shadowRadius
        
        userPhoto.frame = shadowSubview.bounds
        userPhoto.image = image
        userPhoto.layer.borderWidth = 0.5
        userPhoto.clipsToBounds = true
        userPhoto.layer.cornerRadius = 20
        
        shadowSubview.addSubview(userPhoto)
        
        addSubview(shadowSubview)
    }
    
}
