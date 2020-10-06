//
//  FriendsGalleryController.swift
//  vkClient
//
//  Created by Anna Luchechko on 06.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//

import UIKit

class FriendsGalleryController: UIViewController {
    
    let galleryScrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        scroll.showsVerticalScrollIndicator = false
        scroll.showsHorizontalScrollIndicator = false
        scroll.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(galleryScrollView)
        
        
        setupImages()
    }

    
    func setupImages(){
        
        let images = [
            UIImage(named: "cars"),
            UIImage(named: "cats")
        ]

        for i in 0..<images.count {

            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            imageView.frame = CGRect(x: xPosition, y: 0, width: galleryScrollView.frame.width, height: galleryScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit

            galleryScrollView.contentSize.width = galleryScrollView.frame.width * CGFloat(i + 1)
            galleryScrollView.addSubview(imageView)
            //galleryScrollView.delegate = self


        }

    }

}
