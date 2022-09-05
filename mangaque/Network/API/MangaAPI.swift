//
//  MangaAPI.swift
//  mangaque
//
//  Created by Artem Raykh on 04.09.2022.
//

import Moya

enum MangaAPI {
    case getManga
    case searchManga(title: String)
    case getRandomManga
    case getMangaAggregate(mangaId: String)
    case getMangaCover(coverId: String)
}

extension MangaAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Configuration.mangaApiUrl)!
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
    
    var method: Method {
        return .get 
    }
    
    var task: Task {
        switch self {
        case .getMangaCover, .getManga, .getRandomManga, .getMangaAggregate:
            return .requestPlain
        case .searchManga(title: let title):
            return .requestParameters(
                parameters: ["title": title],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
