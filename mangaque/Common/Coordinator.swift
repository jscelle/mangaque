//
//  Router.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

final class Coordinator {
    
    static var `default` = Coordinator()
        
    enum Scene {
        case singleManga(manga: MangaViewData)
        case search
    }
    
    func pop(sender: UIViewController?) {
        sender?.navigationController?.popViewController(animated: true)
    }
    
    func push(to scene: Scene, sender: UIViewController) {
        sender.navigationController?.pushViewController(
            getSeague(seague: scene),
            animated: true
        )
    }
    
    func getRootViewController() -> UIViewController {
        return getSeague(seague: .search)
    }
    
    private func getSeague(seague: Scene) -> UIViewController {
        switch seague {
            
        case .singleManga(let manga):
            
            let singleViewModel = SingleMangaViewModel(item: manga)
            return SingleMangaViewController(
                viewModel: singleViewModel,
                coordinator: self
            )
            
        case .search:
            
            let searchViewModel = SearchViewModel()
            return SearchViewController(
                viewModel: searchViewModel,
                coordinator: self
            )
        }
    }
}

