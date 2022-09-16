//
//  Coordinator.swift
//  mangaque
//
//  Created by Artem Raykh on 16.09.2022.
//

import UIKit

protocol Coordinator<Scene> {
    
    var navigationController: UINavigationController { get set }
    
    associatedtype Scene 
    
    func start()
    
    func pop()
    
    func push(to scene: Scene)
    
    func getScene(_ scene: Scene) -> UIViewController?
}
