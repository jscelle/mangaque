//
//  SceneDelegate.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let viewController = Router.shared.getSeague(seague: Router.Scene.search)
        viewController.modalPresentationStyle = .fullScreen
        
        window?.rootViewController = viewController
        window?.makeKeyAndVisible()
    }
}

