//
//  BaseNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 09.08.2022.
//

import Alamofire
import RxCocoa
import RxSwift

enum Result<T, Error> {
    case success(T)
    case failure(Error)
}

enum BaseNetwordErrors: Error {
    case invalidRoute
}

class BaseNetworkManager {
    
    // MARK: Async / await style
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
    
    // MARK: RxSwift style
    func request<T: Decodable>(
        route: BaseRouteBuilder,
        decoder: JSONDecoder = JSONDecoder()
    ) -> Observable<T> {
        
        return Observable.create { observer -> Disposable in
            AF.request(route).validate().response { response in
                
                if let error = response.error {
                    observer.onError(error)
                    return
                }
                
                if let data = response.data {
                    do {
                        
                        let decodedData = try decoder.decode(T.self, from: data)
                        observer.onNext(decodedData)
                        return
                        
                    } catch let error {
                        observer.onError(error)
                        return
                    }
                }
            }
            return Disposables.create()
        }
    }
}
