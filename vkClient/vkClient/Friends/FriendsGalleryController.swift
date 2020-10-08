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
    var currentIndex: Int = 0
    private var currentSign = 0
    private var percent: CGFloat = 0
    
    private var interactiveAnimator: UIViewPropertyAnimator?
        
    private let imageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        layout(imgView: backgroundImageView)
        layout(imgView: imageView)
        setImages()
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(onPan(_:)))
        imageView.addGestureRecognizer(gesture)
    
    }
    
    private func layout(imgView: UIImageView) {
        view.addSubview(imgView)
        NSLayoutConstraint.activate([
            imgView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imgView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            imgView.widthAnchor.constraint(equalTo: view.widthAnchor),
            imgView.heightAnchor.constraint(equalTo: view.widthAnchor)
        ])
    }

    private func setImages() {
        let firstImage = UIImage(named: photosArray[currentIndex])
        var nextIndex = currentIndex + 1
        var backgroundImage: UIImage?
        
        if currentSign > 0 {
            nextIndex = currentIndex - 1
        }
        
        if nextIndex < photosArray.count - 1, nextIndex >= 0 {
            backgroundImage = UIImage(named: photosArray[nextIndex])
        }
        
        imageView.image = firstImage
        backgroundImageView.image = backgroundImage

    }
    
    private func initAnimator() {
        backgroundImageView.alpha = 0.0
        backgroundImageView.transform = .init(translationX: view.frame.width, y: 0)
        interactiveAnimator?.stopAnimation(true)
        interactiveAnimator = UIViewPropertyAnimator(duration: 0.5,
            curve: .easeInOut, animations: {
                let width = CGFloat(self.currentSign) * self.view.frame.width
                let translationTransform = CGAffineTransform(translationX: width, y: 0)
                self.imageView.transform = translationTransform
                
                self.backgroundImageView.alpha = 1.0
                //self.backgroundImageView.transform = translationTransform
                self.backgroundImageView.transform = .identity
            })
        interactiveAnimator?.startAnimation()
        interactiveAnimator?.pauseAnimation()
    }
    
    private func resetImageView() {
        backgroundImageView.alpha = 0.0
        backgroundImageView.transform = .init(translationX: view.frame.width, y: 0)
        imageView.transform = .identity
        
        setImages()
        view.layoutIfNeeded()
        currentSign = 0
        interactiveAnimator = nil
    }
    
    @objc private func onPan(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .changed:
            let translation = gesture.translation(in: view)
            percent = abs(translation.x) / view.frame.width
            let translationX = Int(translation.x)
            let sign = translationX == 0 ? 1 : translationX / abs(translationX)
            
            if interactiveAnimator == nil || sign != currentSign {
                interactiveAnimator?.stopAnimation(true)
                resetImageView()
                interactiveAnimator = nil
                
                if (sign > 0 && currentIndex > 0 || (sign < 0 && currentIndex < photosArray.count - 1)) {
                    currentSign = sign
                    setImages()
                    initAnimator()
                }
            }
            
            interactiveAnimator?.fractionComplete = abs(translation.x) / (self.view.frame.width / 2)
            
        case .ended:
            interactiveAnimator?.addCompletion( { position in
                self.resetImageView()
            })
            
            if percent < 0.33 {
                interactiveAnimator?.stopAnimation(true)
                UIView.animate(withDuration: 0.3) {
                    self.resetImageView()
                }
            } else {
                currentIndex += currentSign * -1
                interactiveAnimator?.continueAnimation(withTimingParameters: nil, durationFactor: 0)
            }
            
        default:
            break
        }
    }
    
}
