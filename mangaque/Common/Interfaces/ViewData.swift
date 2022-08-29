//
//  ViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

enum ViewData<T>{
    case initial
    case loading
    case success(T)
    case failure(Error)
}
