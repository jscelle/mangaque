//
//  MangaErrors.swift
//  mangaque
//
//  Created by Artem Raykh on 19.08.2022.
//

import Foundation

enum MangaErrors: Error {
    case failedToGetId
    case failedToGetTitle
    case failedToGetCoverUrl
    case failedToConvert(from: Any, to: Any)
}
