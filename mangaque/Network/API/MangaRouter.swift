//
//  MangaRouter.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

enum MangaRouter: BaseRouteBuilder {
    
    case getManga
    
    var path: String {
        switch self {
        case .getManga:
            return ""
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getManga:
            return .get
        }
    }
    
    var parameters: RequestParameters {
        switch self {
        case .getManga:
            return .url([:])
        }
    }
    
}
