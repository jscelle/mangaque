//
//  MangaNetworkManager.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Alamofire

class MainMangaManager: BaseNetworkManager {
    
    func getManga() async -> Result<MangaItem, Error> {
        return await request(route: MangaRouter.getManga)
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
