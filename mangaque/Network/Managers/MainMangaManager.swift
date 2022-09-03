//
//  MangaNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire
import RxSwift

final class MainMangaManager: BaseNetworkManager {
    
    private let disposeBag = DisposeBag()
    
    func getManga() -> Observable<MangaModel> {
        return request(route: MangaRouter.getManga)
    }
    
    func searchManga(title: String) async -> Result<MangaModel, Error> {
        return await request(route: MangaRouter.searchManga(title: title))
    }
    
    func searchManga(title: String) -> Observable<MangaModel> {
        return request(
            route: MangaRouter.searchManga(title: title)
        )
    }
    
    private func getMangaCover(coverId: String) async -> Result<CoverItem, Error> {
        return await request(route: MangaRouter.getMangaCover(coverId: coverId))
    }
    
    func getCoverUrl(coverId: String, mangaId: String) async -> URL? {
        
        let coverItem = await getMangaCover(coverId: coverId)
        
        switch coverItem {
            
            case .success(let coverItem):
            
                guard let fileName = coverItem
                    .data?
                    .attributes?
                    .fileName
                else {
                    break
                }
            
                guard let url = Configuration.mangaCoverUrl(
                    mangaId: mangaId,
                    coverFileName: fileName
                ) else {
                    break
                }
                
                return url
                
            case .failure:
                break
        }
        return nil
    }
}
