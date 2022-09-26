//
//  SceneDelegate.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import UIKit
import RxFlow

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let coordinator = FlowCoordinator()
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let flow = MangaFlow()
        
        Flows.use(flow, when: .created) { root in
            window.rootViewController = root
            window.makeKeyAndVisible()
        }
        
        coordinator.coordinate(
            flow: flow,
            with: OneStepper(
                withSingleStep: MangaStep.searchManga
            )
        )
    }
}

