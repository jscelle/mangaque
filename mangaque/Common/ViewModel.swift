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

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}

open class ViewModel: Stepper {
        
    public var steps = PublishRelay<Step>()
    
    let disposeBag = DisposeBag()
    
}
