//
//  MangaPageCollectionViewCell.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit
import Kingfisher

class MangaPageTableViewCell: UITableViewCell {
    
    public lazy var pageImageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var imageLoaded: (()->())?
    
    var url: URL? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
        guard let url = url else {
            return
        }
        
        pageImageView.contentMode = .scaleAspectFit
        
        addSubview(self.pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageImageView.kf.setImage(with: url, options: [])
        
    }
}
