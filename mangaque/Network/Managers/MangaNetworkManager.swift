//
//  MangaNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

class MangaNetworkManager: BaseNetworkManager {
    
    func getManga(comletionHandler: @escaping (_ data: MangaItem?, _ error: Error?) -> ()) {
        request(route: MangaRouter.getManga) { (data: MangaItem?, error: Error?) in
            comletionHandler(data, error)
        }
    }
    
    func getMangaAggregate(mangaId: String, comletionHandler: @escaping (_ data: AggregateItem?, _ error: Error?) -> ()) {
        request(route: MangaRouter.getMangaAggregate(mangaId: mangaId)) { (data: AggregateItem?, error: Error?) in
            comletionHandler(data, error)
        }
    }
}
