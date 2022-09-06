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
    var outputData = PublishSubject<Output>()
        
    func getOutput() { }
}
