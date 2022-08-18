//
//  MangaCollectionView + CollectionViewDelegates.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit


extension MangaPageCollectionView {
    #warning("TODO: Not show table view untill it filled and resized")
    func createTableView() -> UITableView {
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = .clear
        tableView.register(MangaPageTableViewCell.self, forCellReuseIdentifier: "MangaPageTableViewCell")
        
        tableView.dataSource = self
        
        return tableView
    }
}

extension MangaPageCollectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageImages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MangaPageTableViewCell", for: indexPath) as! MangaPageTableViewCell
        
        cell.data = pageImages[indexPath.row]
        
        return cell
    }
}

extension MangaPageCollectionView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

