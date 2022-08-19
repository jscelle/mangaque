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
        guard let url = Configuration.sourceQualityImageUrl(hash: hash, fileName: fileName) else {
            return .failure(MangaErrors.failedToConvert(from: String.self, to: URL.self))
        }
        return await getData(route: url)
    }
}
