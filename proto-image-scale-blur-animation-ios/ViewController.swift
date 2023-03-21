//
//  ViewController.swift
//  proto-image-scale-blur-animation-ios
//
//  Created by Santosh Krishnamurthy on 3/20/23.
//

import UIKit

class ViewController: UIViewController {

    // create a image view with an image
    let imageView = UIImageView(image: UIImage(named: "test"))
    
    // animation instance property
    let animator = UIViewPropertyAnimator(duration: 2.0, curve: .linear, animations: nil)
    // Visual Effect instance property
    let visualEffectView = UIVisualEffectView(effect: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCenteredImageView()
        setupVisualBlurEffectView()
        setupSlider()
        setupAnimator()
        
        
        // NOTE: if yoou want too add a gesture recognizer to an object, make sure to check "userInteractionEnabled" property first
        // imageView.isUserInteractionEnabled = true
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))

        
    }
    
    func setupVisualBlurEffectView(){
        // let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.regular)
        
        view.addSubview(visualEffectView)
        visualEffectView.fillSuperview()
    }
    
    @objc func handleTap(gesture: UITapGestureRecognizer){
        print(gesture.location(in: view))
    }
    
    @objc func handleSlide(sender: UISlider){
        animator.fractionComplete = CGFloat(sender.value)
        // print("float: \(sender.value); CGFLOAT: \(CGFloat(sender.value))")
    }
    

    
    fileprivate func setupCenteredImageView() {
        // add imageview as subview
        view.addSubview(imageView)
        // change how content is displayed
        imageView.contentMode = .scaleAspectFill
        // clip the image to frame's edges
        imageView.clipsToBounds = true
        
        // refer to uiview extension for autolayet helper functions
        imageView.centerInSuperview(size: CGSize(width: 200, height: 200))
    }
    
    fileprivate func setupSlider() {
        // create a slider
        let slider = UISlider()
        // add slider to view
        view.addSubview(slider)
        // anchor slider under image view
        slider.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, bottom: nil, trailing: imageView.trailingAnchor)
        // if you want continuous input of changed value, use UIControl.Event.valueChanged
        // if you want only the end value after scrolling is complete, use UIControl.Event.touchUpInside
        slider.addTarget(self, action: #selector(handleSlide), for: UIControl.Event.valueChanged)
    }

    fileprivate func setupAnimator() {
        animator.addAnimations {
            // completed animation state
            self.imageView.transform = CGAffineTransform(scaleX: 4, y: 4)
            self.visualEffectView.effect = UIBlurEffect(style: .regular)
        }
    }

}

