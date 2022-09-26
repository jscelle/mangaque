//
//  ViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 29.08.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxFlow

open class ViewModel<Input, Output>: Stepper {
    
    public var steps = PublishRelay<Step>()
    
    let disposeBag = DisposeBag()
    #warning("refactor to driver")
    var inputData = PublishRelay<Input>()
    var outputData = PublishSubject<Output>()
        
    func getOutput() { }
}
