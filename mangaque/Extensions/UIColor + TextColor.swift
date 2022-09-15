//
//  UIColor + TextColor.swift
//  mangaque
//
//  Created by Artem Raykh on 15.09.2022.
//

import UIKit

public extension UIColor {
    func textColor() -> UIColor {
        
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        var brightness: CGFloat = 0.0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        // algorithm from: http://www.w3.org/WAI/ER/WD-AERT/#color-contrast
        brightness = ((r * 299) + (g * 587) + (b * 114)) / 1000;
        if (brightness < 0.3) {
            return UIColor.white
        }
        else {
            return UIColor.black
        }
    }
}
