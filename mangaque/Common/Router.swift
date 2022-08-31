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
        case singleManga(manga: MangaViewData)
        case search
    }
    
    enum Transition {
        case root
    }
    
    func getSeague(seague: Scene) -> UIViewController {
        switch seague {
            
        case .singleManga(let manga):
            
            let singleViewModel = SingleMangaViewModel(item: manga)
            return SingleMangaViewController(viewModel: singleViewModel)
            
        case .search:
            
            let searchViewModel = SearchViewModel()
            return SearchViewController(viewModel: searchViewModel)
        }
    }
}

