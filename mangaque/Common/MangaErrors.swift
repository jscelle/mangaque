//
//  MangaErrors.swift
//  mangaque
//
//  Created by Artem Raykh on 19.08.2022.
//

import Foundation

enum MangaErrors: Error {
    case failedToGetManga
    case failedToLoadImages
    case failedToGetImagesUrls
    
    var localizedDescription: String {
        switch self {
        case .failedToGetManga:
            return "Failed to load manga"
        case .failedToLoadImages:
            return "Failed to load images"
        case .failedToGetImagesUrls:
            return "Failed to get images urls"
        }
    }
}
