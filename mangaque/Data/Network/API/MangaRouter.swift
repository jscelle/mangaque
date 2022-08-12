//
//  MangaRouter.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

enum MangaRouter: BaseRouteBuilder {
    
    case getManga
    case getRandomManga
    case getMangaAggregate(mangaId: String)
    
    var path: String {
        switch self {
        case .getManga:
            return "/manga"
        case .getRandomManga:
            return "/manga/random"
        case .getMangaAggregate(mangaId: let mangaId):
            return "/manga/\(mangaId)/aggregate"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getManga:
            return .get
        case .getRandomManga:
            return .get
        case .getMangaAggregate:
            return .get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getManga:
            return .url([
                "title" : "solo"
            ])
        case .getRandomManga:
            return .url([:])
        case .getMangaAggregate:
            return .url([:])
        }
    }
}
