//
//  FriendsGalleryController.swift
//  vkClient
//
//  Created by Anna Luchechko on 06.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsGalleryController: UIViewController {
    
    var photosArray = [String]()
    let galleryScrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        galleryScrollView.isPagingEnabled = true
        galleryScrollView.showsVerticalScrollIndicator = false
        galleryScrollView.contentInsetAdjustmentBehavior = .never
        galleryScrollView.showsHorizontalScrollIndicator = false
        galleryScrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        
        view.addSubview(galleryScrollView)
        setupImages(photosArray)
        
    }
    
    func setupImages(_ images: [String]){
        for i in 0..<images.count {

            let imageView = UIView(frame:  CGRect(x: 0, y: 0, width: galleryScrollView.frame.width, height: galleryScrollView.frame.height))
            let image = UIImageView()

            image.frame = imageView.bounds
            image.frame.origin.x = view.frame.width * CGFloat(i)
            image.image = UIImage(named: images[i])
            image.contentMode = .scaleAspectFit
            
            imageView.addSubview(image)

            galleryScrollView.contentSize.width = galleryScrollView.frame.width * CGFloat(i + 1)
            galleryScrollView.contentSize.height = view.frame.height
            galleryScrollView.addSubview(imageView)
            
        }
    }

}
