//
//  BaseRouteBuilder.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import Alamofire

enum RequestParameters {
    case url(_ : Parameters)
}

// MARK: We do not need headers for mangadex api
protocol BaseRouteBuilder: URLRequestConvertible {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParameters { get }
}

extension BaseRouteBuilder {
    
    func asURLRequest() throws -> URLRequest {
        
        let baseURL = URL(string: Configuration.mangaApiUrl)!
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        switch parameters {
            case .url(let parameters):
                let filteredParameters = parameters.filter { $0.value as? Any.Type != NSNull.self }
                let encoder = Alamofire.URLEncoding(
                    destination: .queryString,
                    arrayEncoding: .noBrackets,
                    boolEncoding: .literal
                )
                do {
                    urlRequest = try encoder.encode(
                        urlRequest,
                        with: filteredParameters
                    )
                } catch {
                    throw error
                }
            }
        return urlRequest
    }
}

