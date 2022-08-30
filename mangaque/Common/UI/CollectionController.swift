//
//  CollectionController.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

class CollectionController<T>: ViewController<T> {
    
    var collectionData = PublishRelay<T>()
    
    override func eventsSubscribe() {
        
        super.eventsSubscribe()
        
        viewModel
            .data
            .observe(on: MainScheduler.instance)
            .bind(to: collectionData)
            .disposed(by: disposeBag)
    }
}
