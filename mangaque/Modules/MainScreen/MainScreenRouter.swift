//
//  MainScreenRouter.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit
import Alamofire

enum MainScreenRoutes: String {
    case MainScreen
    case MangaScreen
}

class MainScreenRouter: Router {
    
    private weak var viewModel: MainScreenMangaViewModel!
    
    init(viewModel: MainScreenMangaViewModel) {
        self.viewModel = viewModel
    }
    #warning("TODO: Make a swinject resolve for routing")
    
    func route(to route: String, from controller: UIViewController, parameters: Any?) {
        guard let route = MainScreenRoutes(rawValue: route) else {
            return
        }
        
        switch route {
            
        case .MainScreen:
           
            
            
           break
        case .MangaScreen:
            
            guard let item = parameters as? MangaViewDataItem else {
                return
            }
            
            let viewController = SinlgeMangaViewController()
            controller.present(viewController, animated: true)
        }
    }
}

