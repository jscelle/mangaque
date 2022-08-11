//
//  AggregateModelItem.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

// MARK: - AggregateItem
struct AggregateItem: Codable {
    let result: String?
    let volumes: [String: Volume]?
}

// MARK: - Volume
struct Volume: Codable {
    let volume: String?
    let count: Int?
    let chapters: [String: Chapter]?
}

// MARK: - Chapter
struct Chapter: Codable {
    let chapter, id: String?
    let others: [String]?
    let count: Int?
}
