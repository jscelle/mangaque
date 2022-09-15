//
//  UIColor + Blend.swift
//  mangaque
//
//  Created by Artem Raykh on 15.09.2022.
//

import UIKit

public extension Array where Element: UIColor {
    func blend() -> UIColor {
        let componentsSum = self.reduce((
            red: CGFloat(0),
            green: CGFloat(0),
            blue: CGFloat(0)
        )) { (temp, color) in
            
            guard let components = color.cgColor.components else {
                return temp
            }
            
            return (temp.0 + components[0], temp.1 + components[1], temp.2 + components[2])
        }
        
        let components = (
            red: componentsSum.red / CGFloat(self.count),
            green: componentsSum.green / CGFloat(self.count),
            blue: componentsSum.blue / CGFloat(self.count)
        )
        
        return UIColor(
            red: components.red,
            green: components.green,
            blue: components.blue, alpha: 1
        )
    }
}
