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

protocol BaseRouteBuilder: URLRequestConvertible {
    // MARK: API Url for resusable manager
    var headers: HTTPHeaders { get }
    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var urlParams: (_ : Parameters) { get }
    var bodyParams: (_ : Parameters) { get }
}

extension BaseRouteBuilder {
    
    func asURLRequest() throws -> URLRequest {
        
        let baseURL = URL(string: baseURL)!
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = method.rawValue
        
        headers.forEach { header in
            urlRequest.addValue(
                header.value,
                forHTTPHeaderField: header.name
            )
        }
                
        if !urlParams.isEmpty {
            let filteredParameters = urlParams.filter { $0.value as? Any.Type != NSNull.self }
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
                
        if !bodyParams.isEmpty {
            let filteredParameters = bodyParams.filter { $0.value as? Any.Type != NSNull.self }
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

