//
//  SearchTableView.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import UIKit

class SearchCollectionView: UIView {
    
    lazy var collectionView: UICollectionView = {
        
        let collectionViewLayout = UICollectionViewFlowLayout()
        
        let cellWidht = (frame.size.width - 100)
        
        let cellSize = CGSize(
            width: cellWidht,
            height: cellWidht * 2
        )
        
        collectionViewLayout.itemSize = cellSize
        
        collectionViewLayout.scrollDirection = .horizontal
        
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
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.textColor = .white
        textField.textAlignment = .center
        textField.tintColor = .white
        return textField
    }()
    
    lazy var searchImage: UIImageView = {
       let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .white
        
        return imageView
    }()
    
    func setupViews() {
        backgroundColor = R.color.background()
        
        addSubview(searchImage)
        searchImage.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(15)
            make.left.equalToSuperview().inset(30)
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        addSubview(textField)
        textField.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(50)
            make.right.equalToSuperview().inset(50)
            make.height.equalTo(50)
        }
        
        addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
            make.top.equalTo(textField.snp.bottom).inset(-10)
        }
    }
}

