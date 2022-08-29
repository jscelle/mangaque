//
//  SingleMangaCollectionView.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit
import Foundation

class MangaPageTableView: UIView {
    
    lazy var pageTableView = self.createTableView()
    
    func setupViews() {
        addSubview(pageTableView)
        pageTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
