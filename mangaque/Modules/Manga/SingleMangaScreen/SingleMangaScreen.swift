//
//  SingleMangaScreen.swift
//  mangaque
//
//  Created by Artem Raykh on 23.09.2022.
//

import Foundation
import Nivelir

struct SingleMangaScreen: Screen {
    
    let item: MangaViewData
    
    func build(navigator: ScreenNavigator) -> UIViewController {
        
        let viewModel = SingleMangaViewModel(item: item)
        
        let viewController = SingleMangaViewController(
                viewModel: viewModel,
                navigator: navigator
        )
        
        return viewController
    }
}
