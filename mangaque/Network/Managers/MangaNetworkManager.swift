//
//  MangaNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

class MangaNetworkManager: BaseNetworkManager {
    
    func getManga(comletionHandler: @escaping (_ data: EmptyResponse?, _ error: Error?) -> ()) {
        request(route: MangaRouter.getManga) { data, error in
            comletionHandler(data, error)
        }
    }
}
