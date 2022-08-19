//
//  BaseRouteBuilder.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import Alamofire

enum RequestParameters {
    case url(_ : Parameters)
    case body(_ : Parameters)
}

protocol BaseMangaRouteBuilder: URLRequestConvertible {
    // MARK: API Url for resusable manager
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: RequestParameters { get }
}

extension BaseMangaRouteBuilder {
    
    func asURLRequest() throws -> URLRequest {
        
        let baseURL = URL(string: Configuration.mangaApiUrl)!
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        switch parameters {
            
        case .url(let parameters):
            guard !parameters.isEmpty else { break }
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
            
        case .body(let parameters):
            guard !parameters.isEmpty else { break }
            let filteredParameters = parameters.filter { $0.value as? Any.Type != NSNull.self }
            do {
                let encoder = Alamofire.JSONEncoding()
                urlRequest = try encoder.encode(
                    urlRequest,
                    with: filteredParameters
                )
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
        return urlRequest
    }
}

