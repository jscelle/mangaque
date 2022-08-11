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
        
        collectionViewLayout.itemSize = CGSize(width: 100, height: 100)
        
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.register(
            MangaCollectionViewCell.self,
            forCellWithReuseIdentifier: "MangaCollectionViewCell"
        )
        
        collectionView.dataSource = self
        collectionView.backgroundColor = .blue
        
        return collectionView
    }
    
}

extension MangaContainerView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MangaCollectionViewCell",
            for: indexPath
        ) as! MangaCollectionViewCell
        
        cell.configureCell()
        
        return cell
    }
}
