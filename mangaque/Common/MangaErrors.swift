//
//  MangaErrors.swift
//  mangaque
//
//  Created by Artem Raykh on 19.08.2022.
//

import Foundation

enum MangaErrors: Error {
    case failedToGetManga
    case failedToLoad(stage: Stage)
    case failedToGetImagesUrls
    
    enum Stage {
        case getManga
        case getThumbnail
        case getPages
    }
    
    
    var localizedDescription: String {
        switch self {
        case .failedToGetManga:
            return "Failed to load manga"
        case .failedToLoad(stage: let stage):
            return "Failed to load images \(stage)"
        case .failedToGetImagesUrls:
            return "Failed to get images urls"
        }
    }
}
