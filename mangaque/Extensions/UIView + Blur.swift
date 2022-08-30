//
//  UIView + Blur.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import UIKit

extension UIView {
    func applyBlurEffect() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}
