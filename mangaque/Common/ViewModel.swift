//
//  ViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 29.08.2022.
//

import Foundation
import RxSwift
import RxCocoa

protocol ViewModelInterface {
    func startFetch()
}

class ViewModel<T>: NSObject, ViewModelInterface {
    
    var data = PublishSubject<T>()
    
    var error = PublishSubject<Error>()
    
    var loading = PublishSubject<Bool>()
    
    func startFetch() {
        loading.onNext(true)
        print("started fetching")
    }
}
