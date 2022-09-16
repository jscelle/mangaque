//
//  Navigatable.swift
//  mangaque
//
//  Created by Artem Raykh on 15.09.2022.
//

import UIKit

protocol Navigatable {
    var coordinator: any Coordinator { get set }
}
