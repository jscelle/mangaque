//
//  MangaPageCollectionViewCell.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit

class MangaPageTableViewCell: UITableViewCell {
    
    public lazy var pageImageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var imageLoaded: (()->())?
    
    var data: UIImage? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
        guard let data = data else {
            return
        }
        
        pageImageView.contentMode = .scaleAspectFit
        
        addSubview(self.pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageImageView.image = data
        
    }
}
