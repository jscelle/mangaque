//
//  MangaFlow.swift
//  mangaque
//
//  Created by Artem Raykh on 26.09.2022.
//

import Foundation
import RxFlow

class MangaFlow: Flow {
    
    var root: Presentable {
        return self.rootViewController
    }
    
    var rootViewController = UINavigationController()
    
    func navigate(to step: Step) -> FlowContributors {
        guard let step = step as? MangaStep else {
            return .none
        }
        
        switch step {
        case .searchManga:
            return searchScreen()
        case .singleManga(item: let item):
            return singleManga(item: item)
        default:
            return .none
        }
    }
    
    private func searchScreen() -> FlowContributors {
        
        let viewModel = SearchViewModel()
        let viewController = SearchViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: false)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: viewController,
                withNextStepper: viewModel
            )
        )
    }
    
    private func singleManga(item: MangaViewData) -> FlowContributors {
        
        let viewModel = SingleMangaViewModel(item: item)
        let viewController = SingleMangaViewController(viewModel: viewModel)
        
        rootViewController.pushViewController(viewController, animated: true)
        
        return .one(
            flowContributor: .contribute(
                withNextPresentable: viewController,
                withNextStepper: viewModel
            )
        )
    }
}
