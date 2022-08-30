//
//  MangaCollectionView + CollectionViewDelegates.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit


extension MangaPageTableView {

    func createTableView() -> UITableView {
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .clear
        tableView.register(MangaPageTableViewCell.self, forCellReuseIdentifier: "MangaPageTableViewCell")
        tableView.backgroundColor = R.color.background()
        
        return tableView
    }
}

