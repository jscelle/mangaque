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
        
        addSubview(pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageImageView.kf.setImage(
            with: url,
            options: [.alsoPrefetchToMemory]
        ) { result in
            switch result {
            case .success(let image):
                break
            case .failure(let error):
                #warning("present error")
                break
            }
        }
    }
}
