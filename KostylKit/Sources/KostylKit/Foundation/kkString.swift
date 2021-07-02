//
//  File.swift
//  
//
//  Created by   Валерий Мельников on 02.07.2021.
//

import Foundation
extension String {
    public func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    public mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    
    
    public func uppercasedFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }

    mutating func uppercasedFirstLetter() {
        self = self.uppercasedFirstLetter()
    }
}
