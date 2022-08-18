//
//  ChapterData.swift
//  mangaque
//
//  Created by Artem Raykh on 18.08.2022.
//

import Foundation

struct ChapterDataModel: Codable {
    let result: String?
    let baseURL: String?
    let chapter: ChapterData?

    enum CodingKeys: String, CodingKey {
        case result
        case baseURL = "baseUrl"
        case chapter
    }
}

// MARK: - Chapter
struct ChapterData: Codable {
    let hash: String?
    let data, dataSaver: [String]?
}
