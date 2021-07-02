//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
import UIKit

extension UITableView {
    
    // MARK: - Registe Cells
    
  open func registerCellFromNib(_ nameCell: String) -> Void{
        let nib = UINib(nibName: nameCell, bundle: nil)
        self.register(nib, forCellReuseIdentifier: nameCell)
    }
    
    
    open func removeSeparatorsOfEmptyCells() {
           tableFooterView = UIView(frame: .zero)
       }
       
   // Remove Separators Of Empty Cells And Last Cell
    open  func removeSeparatorsOfEmptyCellsAndLastCell() {
           tableFooterView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 0, height: 1)))
       }
}
