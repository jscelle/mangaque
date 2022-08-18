//
//  MangaPageCollectionViewCell.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit

class MangaPageCollectionViewCell: UICollectionViewCell {
    
    private let pageImageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
