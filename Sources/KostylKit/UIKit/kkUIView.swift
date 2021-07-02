//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit

extension UIView {
    
   open func fixInView(_ container: UIView!) -> Void{
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false;
        self.frame = container.frame;
        container.addSubview(self);
        NSLayoutConstraint(item: self, attribute: .leading, relatedBy: .equal, toItem: container, attribute: .leading, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .trailing, relatedBy: .equal, toItem: container, attribute: .trailing, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: container, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: container, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
    }
    
  open func onClick(target: Any, _ selector: Selector) {
        isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: selector)
        addGestureRecognizer(tap)
    }
    
    
    open  func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
  open  var renderedImage: UIImage {
        // rect of capure
        let rect = self.bounds
        
        // create the context of bitmap
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context: CGContext = UIGraphicsGetCurrentContext()!

        self.layer.render(in: context)
        // self.layer.render(in: context)
        // get a image from current context bitmap
        let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return capturedImage
    }
    
   open func fadeIn(duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in }) {
        self.alpha = 0.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.isHidden = false
            self.alpha = 1.0
        }, completion: completion)
    }
    open  func fadeOut(duration: TimeInterval = 1.5, delay: TimeInterval = 0.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in }) {
        self.alpha = 1.0
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseOut, animations: {
            self.isHidden = true
            self.alpha = 0.0
        }, completion: completion)
    }
    
    open  func vibto(style : UIImpactFeedbackGenerator.FeedbackStyle){
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
   open func drawBorder(edges: [UIRectEdge], borderWidth: CGFloat, color: UIColor, margin: CGFloat) {
       for item in edges {
           let borderLayer: CALayer = CALayer()
           borderLayer.borderColor = color.cgColor
           borderLayer.borderWidth = borderWidth
           switch item {
           case .top:
               borderLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: borderWidth)
           case .left:
               borderLayer.frame =  CGRect(x: 0, y: margin, width: borderWidth, height: frame.height - (margin*2))
           case .bottom:
               borderLayer.frame = CGRect(x: 0, y: frame.height - borderWidth, width: frame.width, height: borderWidth)
           case .right:
               borderLayer.frame = CGRect(x: frame.width - borderWidth, y: margin, width: borderWidth, height: frame.height - (margin*2))
           case .all:
               drawBorder(edges: [.top, .left, .bottom, .right], borderWidth: borderWidth, color: color, margin: margin)
           default:
               break
           }
           self.layer.addSublayer(borderLayer)
       }
   }
    
}
