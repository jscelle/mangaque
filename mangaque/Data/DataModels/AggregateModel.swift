//
//  AggregateModelItem.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

// MARK: - AggregateItem
struct AggregateModel: Codable {
    let result: String?
    let volumes: [String: Volume]?
}

// MARK: - VolumesAdditionalProp1
struct Volume: Codable {
    let volume: String?
    let count: Int?
    let chapters: [String: Chapter]?
}

// MARK: - ChaptersAdditionalProp1
struct Chapter: Codable {
    let chapter, id: String?
    let others: [String]?
    let count: Int?
}
