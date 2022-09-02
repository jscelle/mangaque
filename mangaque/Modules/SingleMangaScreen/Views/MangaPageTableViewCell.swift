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
    
    internal override func configureCell() {
        
        guard let data = data else {
            return
        }
        
        pageImageView.contentMode = .scaleAspectFit
        
        addSubview(pageImageView)
        
        pageImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        pageImageView.kf.setImage(with: data.resource) { result in
            switch result {
            case .success(let image):
                
                #warning("ui stop while image redrawing")
                
                let mangaqueImage = MangaqueImage()
                mangaqueImage.redrawImage(
                    image: image.image,
                    translator: .none,
                    textColor: .auto,
                    backgroundColor: .auto
                ) { [weak self] image, error in

                        if let error = error {
                            #warning("add error handler")
                            print(error)
                        }
                        if let image = image {
                            self?.pageImageView.image = image
                        }
                    }
            case .failure(let error):
                print(error)
                #warning("add error hanlder")
            }
        }
    }
}
