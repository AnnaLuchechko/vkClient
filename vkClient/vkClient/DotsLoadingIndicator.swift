//
//  DotsLoadingIndicator.swift
//  vkClient
//
//  Created by Anna Luchechko on 05.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

class DotsLoadingIndicator: UIView {
    
    private var firstDot: UIView = UIView()
    private var secondDot: UIView = UIView()
    private var thirdDot: UIView = UIView()
    
    
    //called when initialized programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        addDots()
        dotsLoadingAnimation()
        
    }
    
    //called when initialized from storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        addDots()
        dotsLoadingAnimation()

    }
    
    func addDots() {
        firstDot.frame = CGRect(x: frame.width * 0.2 + 15, y: frame.height/2 - 15, width: 30, height: 30)
        firstDot.backgroundColor = .black
        firstDot.layer.cornerRadius = 15

        secondDot.frame = CGRect(x: frame.width * 0.4 + 15, y: frame.height/2 - 15, width: 30, height: 30)
        secondDot.backgroundColor = .black
        secondDot.layer.cornerRadius = 15


        thirdDot.frame = CGRect(x: frame.width * 0.6 + 15, y: frame.height/2 - 15, width: 30, height: 30)
        thirdDot.backgroundColor = .black
        thirdDot.layer.cornerRadius = 15
        
        addSubview(firstDot)
        addSubview(secondDot)
        addSubview(thirdDot)
        
    }
    
    func dotsLoadingAnimation() {
        UIView.animate(withDuration: 1.0, delay: 0.0, options: [.repeat, .autoreverse], animations: {
            self.firstDot.alpha = 0.3
            self.secondDot.alpha = 0.5
            self.thirdDot.alpha = 0.8
            self.firstDot.alpha = 0.8
            self.secondDot.alpha = 0.3
            self.thirdDot.alpha = 0.5
        
        })
        
        

    }

}
