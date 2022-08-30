//
//  SearchView.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import UIKit

class SearchView: UIView {
    
    func setupView() {
        
        backgroundColor = .black.withAlphaComponent(0.4)
        applyBlurEffect()
        
        layer.cornerRadius = 25
        layer.masksToBounds = true
        
        let searchImageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        searchImageView.tintColor = .white
        addSubview(searchImageView)
        
        searchImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(15)
        }
    }
}
