//
//  CollectionController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

class CollectionController<Input, Output>: ViewController<Input, Output> {
    
    var collectionData = PublishRelay<Output>()
    
    override func eventsSubscribe() {
        
        super.eventsSubscribe()
        
        viewModel
            .outputData
            .observe(on: MainScheduler.instance)
            .bind(to: collectionData)
            .disposed(by: disposeBag)
    }
}
