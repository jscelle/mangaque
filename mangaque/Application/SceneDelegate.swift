//
//  SceneDelegate.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import UIKit
import Nivelir

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        setupCoordinator(scene: windowScene)
    }
    
    private func setupCoordinator(scene: UIWindowScene) {
        let window = UIWindow(windowScene: scene)
        
        self.window = window
        
        let navigator = ScreenNavigator(window: window)
        
        navigator.navigate { route in
            route.setRoot(to: SearchScreen())
                .makeKeyAndVisible()
        }
    }
}

