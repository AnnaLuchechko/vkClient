//
//  UserPhotoView.swift
//  vkClient
//
//  Created by Anna Luchechko on 26.07.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

@IBDesignable class UserPhotoView: UIView {
        
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
        shadowSubview.frame.size = CGSize(width: 200, height: 200)
        shadowSubview.clipsToBounds = false
        shadowSubview.layer.shadowColor = shadowColor.cgColor
        shadowSubview.layer.shadowOpacity = shadowOpacity
        shadowSubview.layer.shadowOffset = CGSize.zero
        shadowSubview.layer.shadowRadius = shadowRadius
        
        let userPhoto = UIImageView(frame: shadowSubview.bounds)
        userPhoto.image = UIImage(named: "cars")
        userPhoto.layer.borderWidth = 1
        userPhoto.clipsToBounds = true
        userPhoto.layer.cornerRadius = 100
        
        shadowSubview.addSubview(userPhoto)
        
        addSubview(shadowSubview)
        

    }
    
}
