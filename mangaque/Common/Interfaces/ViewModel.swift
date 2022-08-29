//
//  ViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 29.08.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModel {
    
    associatedtype T
    
    var data: BehaviorRelay<ViewData<T>> { get set }
    func startFetch()
}
