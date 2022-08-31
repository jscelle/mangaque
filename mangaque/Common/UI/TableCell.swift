//
//  TableCell.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import UIKit

class TableCell<T>: UITableViewCell {
    
    var data: T? {
        didSet {
            configureCell()
        }
    }
    
    func configureCell() { }
}
