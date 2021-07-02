//
//  rxExtensions.swift
//  Live Wallpaper
//
//  Created by   Валерий Мельников on 25.06.2021.
//

//import Foundation
//import UIKit
//import Lottie
//
//extension rxController {
//    
//    func showAnimatedLoader(_ withBlur: Bool = false) {
//     
//            rxDispatch.thread(dispatchLevel: .main) { [weak self] in
//            guard let `self` = self else {
//                return
//            }
//            
//            UIView.transition(with: self.blurEffectView, duration: 0.2, options: .transitionCrossDissolve, animations: {
//                self.blurEffectView.isHidden = !withBlur
//            })
//            self.animationLoaderView.currentProgress = 0.0
//            self.animationLoaderView.isHidden = false
//            
//            self.animationLoaderView.play()
//        }
//        if #available(iOS 13.0, *) {
//            UIApplication.shared.windows.first?.isUserInteractionEnabled = false
//        } else {
//            UIApplication.shared.beginIgnoringInteractionEvents()
//        }
//        
//    }
//    
//    func hideAnimatedLoader() {
//        rxDispatch.thread(dispatchLevel: .main) { [weak self] in
//            guard let `self` = self else {
//                return
//            }
//            
//            self.animationLoaderView.isHidden = true
//            UIView.transition(with: self.view, duration: 0.3, options: .transitionCrossDissolve, animations: {
//                self.blurEffectView.isHidden = true
//            })
//            
//            self.animationLoaderView.stop()
//        }
//        if #available(iOS 13.0, *) {
//            UIApplication.shared.windows.first?.isUserInteractionEnabled = true
//        } else {
//            UIApplication.shared.endIgnoringInteractionEvents()
//        }
//    }
//}
//
//fileprivate extension rxController {
//    
//    
//    private struct AssociatedKeys {
//        static var kAnimationDoneView = "key_animationView"
//        static var kAnimationLoaderView = "key_animationLoaderView"
//        static var kBlurEffectView = "key_blurEffectView"
//    }
//    
//    
//    private var animationLoaderView: AnimationView {
//        get {
//            guard let view = objc_getAssociatedObject(self, &AssociatedKeys.kAnimationLoaderView) as? AnimationView else {
//                return initAnimationLoaderView()
//            }
//            
//            return view
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &AssociatedKeys.kAnimationLoaderView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    private var blurEffectView: UIVisualEffectView {
//        get {
//            guard let effectView = objc_getAssociatedObject(self, &AssociatedKeys.kBlurEffectView) as? UIVisualEffectView else {
//                return initBlurEffectView()
//            }
//            
//            return effectView
//        }
//        set(newValue) {
//            objc_setAssociatedObject(self, &AssociatedKeys.kBlurEffectView, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
//        }
//    }
//    
//    
//    private func initAnimationLoaderView() -> AnimationView {
//        let animationView = AnimationView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
//        let animation: Animation? = Animation.named(R.file.animationLoadingJson.name)
//        animationView.animation = animation
//        animationView.contentMode = .scaleAspectFill
//        animationView.loopMode = .loop
//        animationView.backgroundBehavior = .pauseAndRestore
//        animationView.animationSpeed = 1.0
//        animationView.backgroundColor = .clear
//        
//        view.addSubview(animationView)
//        animationView.translatesAutoresizingMaskIntoConstraints = false
//        animationView.widthAnchor.constraint(equalToConstant: 300).isActive = true
//        animationView.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        
//        animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0.0).isActive = true
//        animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0.0).isActive = true
//        
//        self.animationLoaderView = animationView
//        
//        return animationView
//    }
//    
//    private func initBlurEffectView() -> UIVisualEffectView {
//        let blurEffect = UIBlurEffect(style: .systemChromeMaterial)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.frame
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        
//        view.addSubview(blurEffectView)
//        self.blurEffectView = blurEffectView
//        return blurEffectView
//    }
//}
