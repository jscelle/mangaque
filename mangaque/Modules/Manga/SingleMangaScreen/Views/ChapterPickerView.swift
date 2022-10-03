//
//  ChapterPickerView.swift
//  mangaque
//
//  Created by Artem Raykh on 29.09.2022.
//

import Foundation
import SnapKit
import RxSwift

class ChapterPickerView: UIView {
    
    var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    func setupViews() {
        addSubview(pickerView)
    }
    
}
