//
//  RxSwift + InfixOperator.swift
//  mangaque
//
//  Created by Artem Raykh on 31.08.2022.
//

import RxCocoa
import RxSwift

infix operator <->

@discardableResult func <-><T>(
        property: ControlProperty<T>,
        variable: PublishRelay<T>
    ) -> Disposable {
    let variableToProperty = variable.asObservable()
        .bind(to: property)

    let propertyToVariable = property
        .subscribe(
            onNext: { variable.accept($0) }
    )

    return Disposables.create(variableToProperty, propertyToVariable)
}
