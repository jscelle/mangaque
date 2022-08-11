//
//  MangaContainerView + CollectionView.swift
//  mangaque
//
//  Created by Artyom Raykh on 11.08.2022.
//

import UIKit

extension MangaContainerView {
    
    func createCollectionView() -> UICollectionView {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
         
        let cellWidht = (frame.size.width - 30) / 2
        
        let cellSize = CGSize(
            width: cellWidht,
            height: cellWidht * 2
        )
        
        collectionViewLayout.itemSize = cellSize
        
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.register(
            MangaCollectionViewCell.self,
            forCellWithReuseIdentifier: "MangaCollectionViewCell"
        )
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        
        return collectionView
    }
    
}

extension MangaContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MangaCollectionViewCell",
            for: indexPath
        ) as! MangaCollectionViewCell
        
        return cell
    }
}
