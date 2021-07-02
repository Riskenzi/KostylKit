//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit

extension UILabel {
    
   open func shadow() {
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 3.0
        self.layer.shadowOpacity = 8
        self.layer.masksToBounds = false
        self.layer.shouldRasterize = true
    }
    
}
