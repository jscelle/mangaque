//
//  MangaCollectionView + CollectionViewDelegates.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import UIKit

extension MangaPageCollectionView {
    
    func createTableView() -> UITableView {
        
        let tableView = UITableView(frame: CGRect.zero)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 1000
        tableView.separatorColor = .clear
        tableView.register(MangaPageTableViewCell.self, forCellReuseIdentifier: "MangaPageTableViewCell")
        
        tableView.dataSource = self
        
        return tableView
    }
}

extension MangaPageCollectionView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageUrls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MangaPageTableViewCell", for: indexPath) as! MangaPageTableViewCell
        
        cell.data = pageUrls[indexPath.row]
        
        return cell
    }
    
    
}

