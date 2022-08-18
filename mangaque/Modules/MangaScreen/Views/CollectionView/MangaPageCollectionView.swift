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
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            break
            #warning("TODO: Loading screen")
        case .loading:
            break
        case .success(let pages):
            
            print(pages)
            
            break
        case .failure(let error):
            
            print(error)
            
            break
        }
        
    }
}
