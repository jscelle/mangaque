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

class ViewModel<Input, Output>: NSObject, ViewModelInterface {
    
    let disposeBag = DisposeBag()
    
    var outputData = PublishRelay<Output>()
    var inputData = PublishRelay<Input>()
    
    var error = PublishRelay<Error>()
    
    var loading = PublishRelay<Bool>()
    
    func startFetch() { }
}

struct Empty { }
