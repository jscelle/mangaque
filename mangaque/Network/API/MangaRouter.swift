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
    
    var path: String {
        switch self {
        case .getManga:
            return "/manga"
        case .getRandomManga:
            return "/manga/random"
        }
        
    }
    
    var method: HTTPMethod {
        switch self {
        case .getManga:
            return .get
        case .getRandomManga:
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
        }
    }
}
