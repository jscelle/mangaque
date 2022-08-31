//
//  TranslatorAPIRouter.swift
//  mangaque
//
//  Created by Artem Raykh on 31.08.2022.
//

import Foundation
import Alamofire

enum TranslatorAPIRouter: BaseRouteBuilder {    
    
    case detectLanguage(text: String)
    
    var headers: HTTPHeaders {
        var headers = HTTPHeaders()
        
        headers.add(name: "content-type", value: "application/json")
        headers.add(name: "X-RapidAPI-Key", value: "ef2ff4edc5mshcaa88e744885781p1b48f3jsn47871268beea")
        headers.add(name: "X-RapidAPI-Host", value: "microsoft-translator-text.p.rapidapi.com")
        
        return headers
    }
    
    var baseURL: String {
        return "https://microsoft-translator-text.p.rapidapi.com"
    }
    
    var path: String {
        switch self {
        case .detectLanguage:
            return "/Detect"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .detectLanguage:
            return .post
        }
    }
    
    var urlParams: (Parameters) {
        return ["api-version" : "3.0"]
    }
    
    var bodyParams: (Parameters) {
        switch self {
        case .detectLanguage(text: let text):
            return ["Text" : text]
        }
    }
}
