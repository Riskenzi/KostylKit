//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit

public enum MaskProgressViewDirection {
    case vertical
    case horizontal
}

open class CoreGBar: UIView {

    let liquidView = UIView() //is going to be animated from bottom to top
    let shapeView = UIImageView() //is going to mask everything with alpha mask

    
    fileprivate struct GradientLayerPoints {
        static let horizontalStartPoint = CGPoint(x: 1, y: 0.5)
        static let horizontalEndPoint = CGPoint(x: 0, y: 0.5)
        static let verticalStartPoint = CGPoint(x: 0.5, y: 0)
        static let verticalEndPoint = CGPoint(x: 0.5, y: 1)
    }
    
    open fileprivate(set) var progress: Float = 0
    open var animationDuration: TimeInterval = 0.5
    
    open var direction: MaskProgressViewDirection {
        set {
            switch newValue {
            case .vertical:
                gradientLayer.startPoint = GradientLayerPoints.verticalStartPoint
                gradientLayer.endPoint = GradientLayerPoints.verticalEndPoint
            case .horizontal:
                gradientLayer.startPoint = GradientLayerPoints.horizontalStartPoint
                gradientLayer.endPoint = GradientLayerPoints.horizontalEndPoint
            }
        }
        get {
            if gradientLayer.startPoint.equalTo(GradientLayerPoints.horizontalStartPoint) &&
               gradientLayer.endPoint.equalTo(GradientLayerPoints.horizontalEndPoint) {
                return MaskProgressViewDirection.horizontal
            } else {
                return MaskProgressViewDirection.vertical
            }
        }
    }
    
    
    open var colors: [UIColor]? {
        set {
            if let colors = newValue {
                let cgColors = colors.map { $0.cgColor }
                gradientLayer.colors = cgColors
            }
        }
        get {
            guard let colors = gradientLayer.colors else {
                return nil
            }
            let uiColors = colors.map { UIColor(cgColor: $0 as! CGColor) }
            return uiColors
        }
    }
    open var backColor: UIColor? {
        set {
            if let backColor = newValue, let colors = colors, colors.count > 0 {
                var colors = colors
                colors[0] = backColor
                self.colors = colors
            }
            setNeedsDisplay()
        }
        get {
            if let colors = colors, colors.count > 0 {
                return colors[0]
            }
            return nil
        }
    }
    open var frontColor: UIColor? {
        set {
            if let frontColor = newValue, let colors = colors, colors.count > 1 {
                var colors = colors
                colors[1] = frontColor
                self.colors = colors
            }
            setNeedsDisplay()
        }
        get {
            if let colors = colors, colors.count > 1 {
                return colors[1]
            }
            return nil
        }
    }
    open var gradientLayer: CAGradientLayer {
        return layer as! CAGradientLayer
    }
    

    override init(frame: CGRect) {
      
        super.init(frame: frame)
      
        setup()
    }




    required public init?(coder aDecoder: NSCoder) {
      
        super.init(coder: aDecoder)
        setup()
    }
 
 
    override open class var layerClass: AnyClass {
        return CAGradientLayer.self
    }
  
    
    func setup() {
        self.backgroundColor = UIColor.clear
        self.liquidView.backgroundColor = UIColor.clear

        self.shapeView.contentMode = .scaleAspectFit
        
        self.addSubview(liquidView)
        self.mask = shapeView

        layoutIfNeeded()
        
        setProgress(0, animated: false)
        backgroundColor = .clear
        colors = [.clear, .clear]
    }

    open override func layoutSubviews() {
        super.layoutSubviews()

        liquidView.frame = self.bounds
        shapeView.frame = self.bounds
    }
        
    open func setProgress(_ progress: Float, animated: Bool) {
        let progress = 1 - min(max(progress, 0), 1)
        let newLocations = [progress, progress]
        
        if animated {
            let animation = CABasicAnimation(keyPath: "locations")
            animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            animation.duration = animationDuration
            animation.fromValue = gradientLayer.locations
            animation.toValue = newLocations
            gradientLayer.add(animation, forKey: "animateLocations")
        } else {
            gradientLayer.setNeedsDisplay()
        }
        gradientLayer.locations = newLocations.map { NSNumber(value: $0) }
        self.progress = progress
    }
}


