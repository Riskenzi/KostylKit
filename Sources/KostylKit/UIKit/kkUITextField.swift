//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit

extension UITextField {
   open func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 20))
        self.leftView = paddingView;
        self.leftViewMode = .always;
        self.rightView = paddingView;
        self.rightViewMode = .always;
        self.backgroundColor = #colorLiteral(red: 0.02352941176, green: 0.2196078431, blue: 0.5019607843, alpha: 0.7530388232)
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.textColor = UIColor.white
    }
}
