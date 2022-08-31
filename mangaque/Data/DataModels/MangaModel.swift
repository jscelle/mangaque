// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let mangaModel = try? newJSONDecoder().decode(MangaModel.self, from: jsonData)

import Foundation

// MARK: - MangaModel
struct MangaModel: Codable {
    let result, response: String?
    let data: [Datum]?
    let limit, offset, total: Int?
}

// MARK: - Datum
struct Datum: Codable {
    let id: String?
    let type: RelationshipType?
    let attributes: DatumAttributes?
    let relationships: [Relationship]?
}

// MARK: - DatumAttributes
struct DatumAttributes: Codable {
    let title: Title?
    let altTitles: [AltTitle]?
    let attributesDescription: Description?
    let isLocked: Bool?
    let originalLanguage: OriginalLanguage?
    let lastVolume, lastChapter, publicationDemographic: String?
    let status: Status?
    let year: Int?
    let contentRating: String?
    let tags: [Tag]?
    let state: State?
    let chapterNumbersResetOnNewVolume: Bool?
    let createdAt, updatedAt: String?
    let version: Int?
    let availableTranslatedLanguages: [String?]

    enum CodingKeys: String, CodingKey {
        case title, altTitles
        case attributesDescription = "description"
        case isLocked, originalLanguage, lastVolume, lastChapter, publicationDemographic, status, year, contentRating, tags, state, chapterNumbersResetOnNewVolume, createdAt, updatedAt, version, availableTranslatedLanguages
    }
}

// MARK: - AltTitle
struct AltTitle: Codable {
    let en, ja, jaRo, th: String?
    let ko, zh, zhRo, id: String?
    let ru, esLa: String?

    enum CodingKeys: String, CodingKey {
        case en, ja
        case jaRo = "ja-ro"
        case th, ko, zh
        case zhRo = "zh-ro"
        case id, ru
        case esLa = "es-la"
    }
}

// MARK: - Description
struct Description: Codable {
    let en, th, ko, ja: String?
    let ru, esLa: String?

    enum CodingKeys: String, CodingKey {
        case en, th, ko, ja, ru
        case esLa = "es-la"
    }
}

// MARK: - LinksClass
struct LinksClass: Codable {
    let ap, kt, mu: String?
    let amz, raw: String?
    let al, bw, mal: String?
    let engtl: String?
}

enum OriginalLanguage: String, Codable {
    case ja = "ja"
    case ko = "ko"
    case zh = "zh"
}

enum State: String, Codable {
    case published = "published"
}

enum Status: String, Codable {
    case completed = "completed"
    case ongoing = "ongoing"
}

// MARK: - Tag
struct Tag: Codable {
    let id: String?
    let type: String?
    let attributes: TagAttributes?
}

// MARK: - TagAttributes
struct TagAttributes: Codable {
    let name: [String: String]?
    let group: String?
    let version: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case group, version
    }
}

// MARK: - Title
struct Title: Codable {
    let en: String?
}

// MARK: - Relationship
struct Relationships: Codable {
    let id: String?
    let type: RelationshipType?
    let related: String?
}

enum RelationshipType: String, Codable {
    case artist = "artist"
    case author = "author"
    case coverArt = "cover_art"
    case manga = "manga"
}
