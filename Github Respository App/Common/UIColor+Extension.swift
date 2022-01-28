//
//  UIColor+Extension.swift
//  Github Respository App
//
//  Created by Inam on 28.01.22.
//

import UIKit

extension UIColor {
    convenience init(hexRed: Int,
                     hexGreen: Int,
                     hexBlue: Int,
                     alpha: CGFloat = 1) {
        assert(0 <= hexRed && hexRed <= 255, "Invalid red value")
        assert(0 <= hexGreen && hexGreen <= 255, "Invalid green value")
        assert(0 <= hexBlue && hexBlue <= 255, "Invalid blue value")
        
        let red = CGFloat(hexRed) / 255.0
        let green = CGFloat(hexGreen) / 255.0
        let blue = CGFloat(hexBlue) / 255.0
        
        self.init(red: red,
                  green: green,
                  blue: blue,
                  alpha: alpha)
    }
    
    convenience init(hex: Int, alpha: CGFloat = 1) {
        self.init(hexRed: (hex >> 16) & 0xff,
                  hexGreen: (hex >> 8) & 0xff,
                  hexBlue: hex & 0xff,
                  alpha: alpha)
    }
}
