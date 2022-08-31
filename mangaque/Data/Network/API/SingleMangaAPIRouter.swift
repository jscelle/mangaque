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
    
    var headers: HTTPHeaders {
        return HTTPHeaders()
    }
    
    var baseURL: String {
        return Configuration.mangaApiUrl
    }
    
    var path: String {
        switch self {
        case .getMangaAppregiate(let mangaId):
            return "/manga/\(mangaId)/aggregate"
        case .getChapterData(chapterId: let chapterId):
            return "/at-home/server/\(chapterId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMangaAppregiate:
            return .get
        case .getChapterData:
            return .get
        
        }
    }
    
    var urlParams: (Parameters) {
        return [:]
    }
    var bodyParams: (Parameters) {
        return [:]
    }
}
