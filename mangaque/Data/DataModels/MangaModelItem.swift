// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let manga = try? newJSONDecoder().decode(Manga.self, from: jsonData)

import Foundation

// MARK: - Manga
struct MangaItem: Codable {
    let result, response: String?
    let data: [Datum]?
    let limit, offset, total: Int?
}

// MARK: - Datum
struct Datum: Codable {
    let id, type: String?
    let attributes: DatumAttributes?
    let relationships: [Relationships]?
}

// MARK: - DatumAttributes
struct DatumAttributes: Codable {
    let title: [String: String]?
    let altTitles: [[String: String]]?
    let attributesDescription: [String: String]?
    let isLocked: Bool?
    let links: [String: String]?
    let originalLanguage, lastVolume, lastChapter, publicationDemographic: String?
    let status: String?
    let year: Int?
    let contentRating: String?
    let chapterNumbersResetOnNewVolume: Bool?
    let tags: [Tag]?
    let state: String?
    let version: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case title, altTitles
        case attributesDescription = "description"
        case isLocked, links, originalLanguage, lastVolume, lastChapter, publicationDemographic, status, year, contentRating, chapterNumbersResetOnNewVolume, tags, state, version, createdAt, updatedAt
    }
}

// MARK: - Tag
struct Tag: Codable {
    let id, type: String?
}

struct Relationships: Codable {
    let id, type: String?
}
