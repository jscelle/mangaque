//
//  SearchView.swift
//  mangaque
//
//  Created by Artyom Raykh on 11.08.2022.
//

import UIKit

class SearchView: UIView {
    
    var textFieldEdited: ((String) -> ())?
    
    private let textField = UITextField()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(textField)
        textField.backgroundColor = .darkGray
        textField.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        textField.layer.cornerRadius = 20
    }
}
