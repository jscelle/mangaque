//
//  MangaCollectionView + CollectionViewDelegates.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit

extension MangaPageCollectionView {
    
    func createCollection() -> UICollectionView {
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        collectionViewLayout.itemSize.width = frame.width
        
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: collectionViewLayout
        )
        
        collectionView.register(
            MangaPageCollectionViewCell.self,
            forCellWithReuseIdentifier: "MangaPageCollectionViewCell"
        )
        
        collectionView.dataSource = self
        
        return collectionView
    }
}

extension MangaPageCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "MangaPageCollectionViewCell",
            for: indexPath
        ) as! MangaPageCollectionViewCell
        
        return cell
    }
}
