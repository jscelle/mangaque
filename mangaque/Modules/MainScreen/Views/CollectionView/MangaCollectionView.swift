//
//  MangaContainerView.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import SnapKit

class MangaCollectionView: UIView {

    var viewData: ViewData<[MangaViewDataItem]> = .initial {
        didSet {
            setNeedsLayout()
        }
    }
    
    var mangaItems: [MangaViewDataItem] = []
    
    lazy var collectionView = createCollectionView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        switch viewData {
        case .initial:
            break
        case .loading:
            #warning("add skeleton view for loading")
            break
        case .success(let success):
            
            setupView()
            
            mangaItems = success
            collectionView.reloadData()
            
            break
        case .failure(let error):
            
            #warning("error")
            print(error)
            
            break
        }
    }
    
    private func setupView() {
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
    }
}
