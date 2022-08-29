//
//  MangaContainerView.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import SnapKit

class MangaCollectionView: UIView {
    
    var mangaItems: [MainViewData] = []
    
    lazy var collectionView = createCollectionView()
    
    func setupView() {
        
        addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
    }
}
