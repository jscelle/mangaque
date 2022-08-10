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

protocol BaseRouteBuilderInterface: URLConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var headers: HTTPHeaders { get }
    var parameters: RequestParameters { get }
}

extension BaseRouteBuilderInterface {
    
}

