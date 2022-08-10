//
//  ViewController.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        let manager = MangaNetworkManager()
        manager.getManga { result, error in
            
        }
    }
}

