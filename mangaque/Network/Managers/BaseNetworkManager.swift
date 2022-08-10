//
//  BaseNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import Foundation
import Alamofire

class BaseNetworkManager {
    
    func request<T: Decodable>(
        route: BaseRouteBuilder,
        decoder: JSONDecoder = JSONDecoder(),
        completionHandler: @escaping ((_ data: T?, _ error: Error?) -> ())
    ) -> DataRequest {
        
        return AF.request(route)
            .validate()
            .response { responseData in
                
                guard let data = responseData.data else {
                    completionHandler(nil, responseData.error)
                    return
                }
                
                do {
                    let responseCodableObject = try decoder.decode(T.self, from: data)
                    completionHandler(responseCodableObject, responseData.error)
                } catch {
                    completionHandler(nil, responseData.error)
                }
        }
    }
}
