//
//  DispatchHelper.swift
//   Live Wallpaper
//
//  Created by   Валерий Мельников on 13.05.2021.
//

import Foundation
import UIKit

open class rxDispatch {
    fileprivate init() {}
    
    
    public static func delay(bySeconds seconds : Double, dispatchLevel : DispatchLevel = .main, completion: @escaping () -> ()) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: completion)
    }
    
    public static func thread(dispatchLevel : DispatchLevel = .main, completion: @escaping () -> ()){
        let dispatchTime = DispatchTime.now() + 0.0
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: completion)
    }
    
    public enum DispatchLevel {
        case main,userInteractive,userInitiated, utility, background,global
        var dispatchQueue : DispatchQueue {
            switch self {
            case .main: return DispatchQueue.main
            case .global: return DispatchQueue.global()
            case .userInteractive : return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated : return DispatchQueue.global(qos: .userInitiated)
            case .utility : return DispatchQueue.global(qos: .utility)
            case .background : return DispatchQueue.global(qos: .background)
        
            }
        }
    }
}
