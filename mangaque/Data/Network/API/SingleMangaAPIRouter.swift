//
//  SingleMangaAPIRouter.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Alamofire

enum SingleMangaAPIRouter: BaseRouteBuilder {
    
    case getMangaAppregiate(mangaId: String)
    
    var path: String {
        switch self {
        case .getMangaAppregiate(let mangaId):
            return "/manga/\(mangaId)/aggregate"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getMangaAppregiate:
            return .get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getMangaAppregiate:
            return .url([:])
        }
    }
    
}
