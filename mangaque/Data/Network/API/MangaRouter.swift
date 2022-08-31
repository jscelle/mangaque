//
//  MangaRouter.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

enum MangaRouter: BaseRouteBuilder {
    
    case getManga
    case searchManga(title: String)
    case getRandomManga
    case getMangaAggregate(mangaId: String)
    case getMangaCover(coverId: String)
    
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    var baseURL: String {
        return Configuration.mangaApiUrl
    }
    
    var path: String {
        switch self {
        case .getManga:
            return "/manga"
        case .getRandomManga:
            return "/manga/random"
        case .getMangaAggregate(mangaId: let mangaId):
            return "/manga/\(mangaId)/aggregate"
        case .getMangaCover(coverId: let coverId):
            return "/cover/\(coverId)"
        case .searchManga:
            return "/manga"
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
        case .getMangaCover:
            return .get
        case .searchManga:
            return .get
        }
    }
    
    var urlParams: (Parameters) {
        switch self {
        case .getManga:
            return [:]
        case .searchManga(title: let title):
            return [ "title" : title ]
        case .getRandomManga:
            return [:]
        case .getMangaAggregate:
            return [:]
        case .getMangaCover:
            return [:]
        }
    }
    
    var bodyParams: (Parameters) {
        return [:]
    }
}
