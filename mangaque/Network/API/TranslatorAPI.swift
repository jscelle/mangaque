//
//  TranslatorAPI.swift
//  mangaque
//
//  Created by Artem Raykh on 11.09.2022.
//

import Foundation
import Moya

enum TranslotorAPI {
    case translate(text: String)
}

extension TranslotorAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://api-free.deepl.com/v2")!
    }
    
    var path: String {
        switch self {
        case .translate:
            return "/translate"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .translate:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .translate(text: let text):
            return .requestParameters(
                parameters: [
                    "text": text,
                    "target_lang": "RU"
                ],
                encoding: URLEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return ["Authorization": "DeepL-Auth-Key \(Secured.deeplAuthKey)"]
    }
}
