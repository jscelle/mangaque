//
//  AggregateModelItem.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

struct AggregateModel: Codable {
    let result: String?
    let volumes: [String: Volume]?
}

struct Volume: Codable {
    let volume: String?
    let count: Int?
    let chapters: [String: Chapter]?
}

struct Chapter: Codable {
    let chapter, id: String?
    let others: [String]?
    let count: Int?
}

extension AggregateModel {
    
    func getFirstChapter() -> Chapter? {
        self
            .volumes?
            .values
            .compactMap { $0 as Volume }
            .first?
            .chapters?
            .first?
            .value
    }
}
