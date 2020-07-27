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
        let borderView = UIView()

        shadowSubview.frame.size = CGSize(width: 200, height: 200)
        shadowSubview.backgroundColor = UIColor.clear
        shadowSubview.layer.shadowColor = UIColor.black.cgColor
        shadowSubview.layer.shadowOffset = CGSize(width: 3, height: 3)
        shadowSubview.layer.shadowOpacity = 0.7
        shadowSubview.layer.shadowRadius = 4.0
        shadowSubview.layer.shadowPath = UIBezierPath(roundedRect: shadowSubview.bounds, cornerRadius: 10).cgPath
        shadowSubview.layer.shouldRasterize = true
        shadowSubview.layer.rasterizationScale = UIScreen.main.scale

        borderView.frame = shadowSubview.bounds
        borderView.layer.cornerRadius = 10
        borderView.layer.borderColor = UIColor.black.cgColor
        borderView.layer.borderWidth = 1.0
        borderView.layer.masksToBounds = true
        shadowSubview.addSubview(borderView)

        let otherSubContent = UIImageView()
        otherSubContent.image = UIImage(named: "cars")
        otherSubContent.contentMode = .scaleToFill
        otherSubContent.frame = borderView.bounds
        otherSubContent.layer.masksToBounds = true
        borderView.addSubview(otherSubContent)

        addSubview(shadowSubview)

    }
    
}
