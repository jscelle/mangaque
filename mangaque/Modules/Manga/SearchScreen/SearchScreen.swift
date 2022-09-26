//
//  SearchScreen.swift
//  mangaque
//
//  Created by Artem Raykh on 23.09.2022.
//

import Foundation
import Nivelir

struct SearchScreen: Screen {
    
    func build(navigator: ScreenNavigator) -> UIViewController {
        
        let viewModel = SearchViewModel()
        
        let viewController = SearchViewController(
            viewModel: viewModel,
            navigator: navigator
        )
        
        return viewController
    }
}
