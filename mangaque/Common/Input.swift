//
//  Input.swift
//  mangaque
//
//  Created by Artem Raykh on 20.09.2022.
//

import RxSwift
import RxCocoa
import RxRelay

protocol Input {
    
}

protocol Output {
    var loading: BehaviorRelay<Bool> { get set }
    var error: PublishRelay<Error> { get set }
}
