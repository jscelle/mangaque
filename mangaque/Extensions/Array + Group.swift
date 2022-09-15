//
//  Array + Group.swift
//  mangaque
//
//  Created by Artem Raykh on 15.09.2022.
//

import Foundation

public extension Array {
    func grouped(by equal: (Element, Element) -> Bool) -> [[Element]] {
        guard let firstElement = first else { return [] }
        guard let splitIndex = firstIndex(where: { !equal($0, firstElement) } ) else { return [self] }
        return [Array(prefix(upTo: splitIndex))] + Array(suffix(from: splitIndex)).grouped(by: equal)
    }
}
