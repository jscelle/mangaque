//
//  Router.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

class Router {
    static let shared = Router()
    
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
            return MainViewController(viewModel: MainViewModel())
        case .singleManga(let manga):
            return SingleMangaViewController(viewModel: <#T##SingleMangaViewModelInterface#>)
        }
    }
}

