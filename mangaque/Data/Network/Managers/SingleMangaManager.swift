//
//  SingleMangaManager.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Alamofire

#warning("TODO: Refactor this")

class SingleMangaManager: BaseNetworkManager {
    
    func getMangaAppregiate(mangaId: String) async -> Result<AggregateModel, Error> {
        return await request(route: SingleMangaAPIRouter.getMangaAppregiate(mangaId: mangaId))
    }
    
    func getChapterData(chapterId: String) async -> Result<ChapterDataModel, Error> {
        return await request(route: SingleMangaAPIRouter.getChapterData(chapterId: chapterId))
    }
    
    func getImageData(hash: String, fileName: String) async -> Result<Data, Error> {
        
        return await request(
            route: SingleMangaAPIRouter.getChapterPages(
                hash: hash,
                fileName: fileName
            )
        )
    }
}
