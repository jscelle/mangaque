//
//  MangaNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

class MangaNetworkManager: BaseNetworkManager {
    
    func getManga() async -> Result<MangaItem, Error> {
        return await request(route: MangaRouter.getManga)
    }
    
    func getMangaAppregate(mangaId: String) async -> Result<AggregateItem, Error> {
        return await request(route: MangaRouter.getMangaAggregate(mangaId: mangaId))
    }
    
    func getMangaCover(coverId: String) async -> Result<CoverItem, Error> {
        return await request(route: MangaRouter.getMangaCover(coverId: coverId))
    }
}
