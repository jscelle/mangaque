//
//  Router.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import UIKit

protocol Router {
    func route(
        to route: String,
        from controller: UIViewController,
        parameters: Any?
    )
}

