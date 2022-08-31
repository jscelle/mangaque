//
//  BaseNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import Alamofire

enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

enum BaseNetwordErrors: Error {
    case invalidRoute
}

class BaseNetworkManager {
    
    func request<T: Decodable>(
        route: BaseRouteBuilder,
        decoder: JSONDecoder = JSONDecoder()
    ) async -> Result<T, Error> {
        
        return await withCheckedContinuation { continuation in
            
            AF.request(route).validate().response { response in
                
                if let error = response.error {
                    continuation.resume(returning: .failure(error))
                    return
                }
                
                if let data = response.data {
                    
                    do {
                        
                        let decodedData = try decoder.decode(T.self, from: data)
                        continuation.resume(returning: .success(decodedData))
                            
                    } catch let error {
                        continuation.resume(returning: .failure(error))
                        return
                    }
                }
            }
        }
    }
    func getData(route: URL) async -> Result<Data, Error> {
        
        return await withCheckedContinuation{ continuation in
            
            AF.request(route).validate().response { response in
                
                if let error = response.error {
                    
                    continuation.resume(returning: .failure(error))
                    return
                }
                
                if let data = response.data {
                    
                    continuation.resume(returning: .success(data))
                    return
                }
            }
        }
    }
}
