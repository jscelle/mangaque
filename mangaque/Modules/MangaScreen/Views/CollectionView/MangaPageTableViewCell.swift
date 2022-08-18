//
//  MangaPageCollectionViewCell.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit

class MangaPageTableViewCell: UITableViewCell {
    
    private let pageImageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var data: URL? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
        guard let data = data else {
            return
        }
        
        
        
        pageImageView.kf.setImage(with: data) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            self.addSubview(self.pageImageView)
            
            self.pageImageView.contentMode = .scaleAspectFit
            self.pageImageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}
