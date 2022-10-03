//
//  MangaPageCollectionViewCell.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit
import Kingfisher
import MangaqueImage

final class MangaPageTableViewCell: TableCell<PageViewData> {
    
    var pageImageView: UIImageView  = {
        let imageView = UIImageView()
        return imageView
    }()
        
    override func configureCell() {
        
        guard let data = data else {
            return
        }
        
        pageImageView.contentMode = .scaleAspectFit
        
        addSubview(pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageImageView.image = data.image 
    }
}
