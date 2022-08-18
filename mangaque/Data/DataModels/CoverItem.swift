//
//  CoverItem.swift
//  mangaque
//
//  Created by Artyom Raykh on 12.08.2022.
//

import Foundation

// MARK: - CoverItem
struct CoverItem: Codable {
    let result, response: String?
    let data: DataClass?
}

// MARK: - DataClass
struct DataClass: Codable {
    let id, type: String?
    let attributes: Attributes?
    let relationships: [Relationship]?
}

// MARK: - Attributes
struct Attributes: Codable {
    let attributesDescription, volume, fileName, locale: String?
    let createdAt, updatedAt: String?
    let version: Int?

    enum CodingKeys: String, CodingKey {
        case attributesDescription = "description"
        case volume, fileName, locale, createdAt, updatedAt, version
    }
}

// MARK: - Relationship
struct Relationship: Codable {
    let id, type: String?
}
