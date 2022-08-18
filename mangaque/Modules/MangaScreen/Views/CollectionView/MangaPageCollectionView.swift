//
//  SingleMangaCollectionView.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit
import Foundation

class MangaPageCollectionView: UIView {
    
    var viewData: ViewData<PagesViewData> = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    private lazy var pageCollectionView = self.createTableView()
    
    var pageImages: [UIImage] = []
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            break
            #warning("TODO: Loading screen")
        case .loading:
            break
        case .success(let pages):
            setupViews()
            
            pageImages = pages.pageImages.compactMap {
                UIImage(data: $0)
            }
            pageCollectionView.reloadData()
            
        case .failure(let error):
            #warning("error handling")
            print(error)
        }
    }
    
    private func setupViews() {
        addSubview(pageCollectionView)
        pageCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
