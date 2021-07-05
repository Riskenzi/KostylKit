//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit

extension UICollectionView {
   open func registerCellFromNib(_ nameCell: String) -> Void{
        let nib = UINib(nibName: nameCell, bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: nameCell)
    }
}
