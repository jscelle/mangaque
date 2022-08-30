//
//  MangaPageCollectionViewCell.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit
import Kingfisher

class MangaPageTableViewCell: UITableViewCell {
    
    var pageImageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
        
    var data: PageViewData? {
        didSet {
            configureCell()
        }
    }
    
    private func configureCell() {
        
        guard let data = data else {
            return
        }
        
        pageImageView.contentMode = .scaleAspectFit
        
        addSubview(pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageImageView.kf.setImage(with: data.resource)
    }
}
