//
//  MangaContainerView + CollectionView.swift
//  mangaque
//
//  Created by Artyom Raykh on 11.08.2022.
//

import UIKit

extension MangaCollectionView {
    
    func createCollectionView() -> UICollectionView {
        
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
    }
}
