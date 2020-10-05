//
//  DotsLoadingIndicator.swift
//  vkClient
//
//  Created by Anna Luchechko on 05.10.2020.
//  Copyright © 2020 Anna Luchechko. All rights reserved.
//
import UIKit

class DotsLoadingIndicator: UIView {
    
    //called when initialized programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addDots(dotsCount: 3)
        
    }
    
    //called when initialized from storyboard
    required init?(coder: NSCoder) {
        super.init(coder: coder)

        addDots(dotsCount: 3)
        
    }
    
    func addDots(dotsCount: Int) {
        var dot = 0
        
        while dot < dotsCount {
            let dotView = UIView(frame: CGRect(x: (frame.width * 0.2 * ((CGFloat(dot) + 1)) + 15),
                                               y: frame.height/2 - 15, width: 30, height: 30))
            dotView.layer.cornerRadius = 15
            addSubview(dotView)
            dotView.backgroundColor = .gray
            dotsLoadingAnimation(view: dotView, delay: Double(dot)/3)
            dot += 1
        }
                
    }
    
    func dotsLoadingAnimation(view: UIView, delay: Double) {
        UIView.animate(withDuration: 1.0, delay: delay, options: [.repeat, .autoreverse], animations: {
            view.alpha = 1.0
            view.alpha = 0.0
        })
        
        

    }

}
