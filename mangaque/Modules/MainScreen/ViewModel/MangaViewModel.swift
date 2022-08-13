//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation
import Dispatch

protocol MangaViewModelInterface {
    var updateMangaViewData: ((ViewData<[MangaViewDataItem]>) -> ())? { get set }
    func startFetch()
}

enum MangaErrors: Error {
    case failedToGetId
    case failedToGetTitle
    case failedToGetCoverUrl
}

final class MangaViewModel: MangaViewModelInterface {
    
    private let mangaManager = MangaNetworkManager()
    
    public var updateMangaViewData: ((ViewData<[MangaViewDataItem]>) -> ())?
    
    init() {
        updateMangaViewData?(.initial)
    }
    
#warning("TODO: ALERT CONTROLLER ")
    
    func startFetch() {
        
        Task {
            
            let mangaItem = await mangaManager.getManga()
            
            switch mangaItem {
                case .success(let mangaItem):
                
                    var mangaItems: [MangaViewDataItem] = []
                    
                    guard let data = mangaItem.data else {
                        return
                    }
                
#warning("im not sure if self cant be actually leaked here ;/")
                
                    await withTaskGroup(of: MangaViewDataItem?.self) { group in
                        
                            for dataItem in data {
                                
                                guard let mangaId = dataItem.id else {
                                    break
                                }
                                
                                guard let mangaTitle = dataItem
                                    .attributes?
                                    .title?["en"] else {
                                    break
                                }
                                
                                guard let coverId = dataItem
                                    .relationships?
                                    .first(where: {
                                        $0.type == "cover_art" })?
                                    .id else {
                                    return
                                }
                                
                                group.addTask {
                                    
                                    let coverItem = await self.mangaManager.getMangaCover(coverId: coverId)
                                    
                                    switch coverItem {
                                    case .success(let coverItem):
                                        
                                        guard let coverFileName = coverItem.data?.attributes?.fileName else {
                                            break
                                        }
                                        
                                        guard let mangaCoverUrl = Configuration.mangaCoverUrl(
                                            mangaId: mangaId,
                                            coverFileName: coverFileName
                                        ) else {
                                            break
                                        }
                                        return MangaViewDataItem(
                                            mangaId: mangaId,
                                            title: mangaTitle,
                                            coverURL: mangaCoverUrl
                                        )
                                        
                                    case .failure(let error):
                                        break
                                    }
                                    return nil
                            }
                        }
                        
                        for await mangaItem in group {
                            if let mangaItem = mangaItem {
                                mangaItems.append(mangaItem)
                            }
                        }
                        updateViewData(data: .success(mangaItems))
                    }
                
            case .failure(let error):
            #warning("error handler")
                updateViewData(data: .failure(error))
            }
        }
    }
    
    func updateViewData(data: ViewData<[MangaViewDataItem]>) {
        DispatchQueue.main.async {
            self.updateMangaViewData?(data)
        }
    }
}
