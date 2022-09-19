//
//  MangaCoordinator.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

enum MangaScenes {
    case singleManga(manga: MangaViewData)
    case search
}

final class MangaCoordinator: Coordinator {
    
    typealias Scenes = MangaScenes
    
    weak var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
        guard let viewController = getScene(.search) else {
            return
        }
        
        navigationController?.pushViewController(viewController, animated: false)
    }
    
    func push(to scene: Scenes) {
        guard let viewController = getScene(scene) else {
            return
        }
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func pop() {
        navigationController?.popViewController(animated: true)
    }
    
    func getScene(_ scene: Scenes) -> UIViewController? {
        
        switch scene {

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

