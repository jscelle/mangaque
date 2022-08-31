//
//  MangaContainerView.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import SnapKit

class MangaCollectionView: UIView {
    
    lazy var collectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        let cellWidht = (frame.size.width - 30) / 2
        
        let cellSize = CGSize(
            width: cellWidht,
            height: cellWidht * 1.7
        )
        
        collectionViewLayout.itemSize = cellSize
        
        let collectionView = UICollectionView(
            frame: bounds,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.register(
            MangaCollectionViewCell.self,
            forCellWithReuseIdentifier: "MangaCollectionViewCell"
        )
        
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
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
