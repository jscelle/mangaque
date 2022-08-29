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
    }
    
    enum Transition {
        case root
    }
    
    func getSeague(seague: Scene) -> UIViewController {
        switch seague {
        case .main:
            return MainViewController(mangaViewModel: MainViewModel())
        }
    }
}

