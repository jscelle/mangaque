//
//  SingleMangaManager.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation

class SingleMangaManager: BaseNetworkManager {
    
    func getMangaAppregiate(mangaId: String) async -> Result<AggregateItem, Error> {
        return await request(route: SingleMangaAPIRouter.getMangaAppregiate(mangaId: mangaId))
    }
    
}
