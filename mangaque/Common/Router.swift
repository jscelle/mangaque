//
//  Router.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

class Router {
    
    static let shared = Router()
    
    private init() {}
    
    enum Scene {
        case main
        case singleManga(manga: MainViewData)
    }
    
    enum Transition {
        case root
    }
    
    func getSeague(seague: Scene) -> UIViewController {
        switch seague {
        case .main:
            
            let mainViewModel = MainViewModel()
            
            return MainViewController(viewModel: mainViewModel)
        case .singleManga(let manga):
            
            let singleViewModel = SingleMangaViewModel(item: manga)
            
            return SingleMangaViewController(viewModel: singleViewModel)
            
        }
    }
}

