//
//  MangaCollectionViewCell.swift
//  mangaque
//
//  Created by Artyom Raykh on 11.08.2022.
//

import UIKit

class MangaCollectionViewCell: UICollectionViewCell {
    
    private lazy var coverImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    func configureCell() {
        
        addSubview(titleLabel)
        addSubview(coverImageView)
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(50)
        }
        
        coverImageView.snp.makeConstraints { make in
            make.bottom.equalTo(titleLabel.snp.top).offset(10)
            make.right.equalToSuperview().inset(10)
            make.left.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(10)
        }
        
        backgroundColor = .white
        
        titleLabel.text = "Manga"
    }
}
