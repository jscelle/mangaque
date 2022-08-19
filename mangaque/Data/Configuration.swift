//
//  Configuration.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

struct Configuration {
    static let mangaApiUrl = "https://api.mangadex.org"
    static let sourceQualityImagesUrl = "https://uploads.mangadex.org/data"
    static func mangaCoverUrl(mangaId: String, coverFileName: String) -> URL? {
        guard let url = URL(
            string: "https://uploads.mangadex.org/covers/\(mangaId)/\(coverFileName).512.jpg"
        ) else {
            return nil
        }
        return url
    }
    static func sourceQualityImageUrl(hash: String, fileName: String) -> URL? {
        guard let url = URL(string: "https://uploads.mangadex.org/data/\(hash)/\(fileName)") else {
            return nil
        }
        return url
    }
}
