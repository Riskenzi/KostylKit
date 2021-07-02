//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit
extension UIWindow {
    
  open func setRootViewController(viewController: UIViewController, withAnimation: Bool) {
        if !withAnimation {
            rootViewController = viewController
            makeKeyAndVisible()
            return
        }

        if let snapshot = snapshotView(afterScreenUpdates: true) {
            viewController.view.addSubview(snapshot)
            rootViewController = viewController
            makeKeyAndVisible()
            
            UIView.animate(withDuration: 0.4, animations: {
                snapshot.layer.opacity = 0
            }, completion: { _ in
                snapshot.removeFromSuperview()
            })
        }
    }
}
