//
//  SceneDelegate.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    #warning("TODO: Swinject here ;/")
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let viewModel = MainViewModel()
        let router = MainScreenRouter(viewModel: viewModel)
        
        let viewController = MainViewController(
            mangaViewModel: viewModel,
            router: router
        )
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

