//
//  rxNavController.swift
//   Live Wallpaper
//
//  Created by   Валерий Мельников on 13.05.2021.
//

import Foundation
import UIKit

open class rxNavController: UINavigationController {

    open override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupAppearances()
    }

    open override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        setupAppearances()
    }
    
    @objc func setupAppearances() -> Void {
        self.makeNavigationTransparent()
        
    }
    
}


extension UINavigationController {
    
    /// Make Navigation Bar transparant.
    open  func makeNavigationTransparent() {
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
    }
    
    @objc open func pushAnimation(vc: UIViewController, duration: CFTimeInterval, type: CATransitionSubtype) {
        vibto(style: .medium)
        let customVcTransition = vc
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        pushViewController(customVcTransition, animated: false)
    }
    
    @objc open func dismissAnimation(duration: CFTimeInterval, type: CATransitionSubtype) {
        vibto(style: .medium)
        let transition = CATransition()
        transition.duration = duration
        transition.type = CATransitionType.push
        transition.subtype = type
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        popViewController(animated: false)
    }
    
    open func vibto(style : UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
