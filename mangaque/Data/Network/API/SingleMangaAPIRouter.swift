//
//  SingleMangaAPIRouter.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Alamofire

enum SingleMangaAPIRouter: BaseRouteBuilder {
    
    case getMangaAppregiate(mangaId: String)
    case getChapterData(chapterId: String)
    case getChapterPages(hash: String, fileName: String)
    
    var apiUrl: String {
        switch self {
        case .getChapterData:
            return Configuration.mangaApiUrl
        case .getMangaAppregiate:
            return Configuration.mangaApiUrl
        case .getChapterPages:
            return Configuration.sourceQualityImagesUrl
        }
    }
    
    var path: String {
        switch self {
        case .getMangaAppregiate(let mangaId):
            return "/manga/\(mangaId)/aggregate"
        case .getChapterData(chapterId: let chapterId):
            return "/at-home/server/\(chapterId)"
        case .getChapterPages(hash: let hash, fileName: let fileName):
            return "\(hash)/\(fileName)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMangaAppregiate:
            return .get
        case .getChapterData:
            return .get
        case .getChapterPages:
            return .get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getMangaAppregiate:
            return .url([:])
        case .getChapterData:
            return .url([:])
        case .getChapterPages:
            return .url([:])
        }
    }
}
