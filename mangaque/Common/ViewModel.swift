//
//  ViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 29.08.2022.
//

import Foundation
import RxSwift
import RxCocoa

open class ViewModel<Input, Output>: NSObject {
    
    let disposeBag = DisposeBag()
    
    var inputData = PublishRelay<Input>()
    var outputData = PublishRelay<Output>()
    
    var error = PublishRelay<Error>()
    
    var loading = BehaviorRelay<Bool>(value: true)
    
    func getOutput() { }
}
