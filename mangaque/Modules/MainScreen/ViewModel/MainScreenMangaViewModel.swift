//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation
import Dispatch

protocol MainScreenMangaViewModelInterface {
    var updateMangaViewData: ((ViewData<[MangaViewDataItem]>) -> ())? { get set }
    func startFetch()
}

final class MainScreenMangaViewModel: MainScreenMangaViewModelInterface {
    
    private let mangaManager = MainMangaManager()
    
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
                
                    await withTaskGroup(of: MangaViewDataItem?.self) { group in
                        
                            for dataItem in data {
                                
                                guard let mangaId = dataItem.id else {
                                    break
                                }
                                
                                guard let mangaTitle = dataItem
                                    .attributes?
                                    .title?
                                    .en else {
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
                                    
                                    guard let coverUrl = await self.mangaManager.getCoverUrl(
                                        coverId: coverId,
                                        mangaId: mangaId
                                    ) else {
                                        return nil
                                    }
                                    
                                    return MangaViewDataItem(
                                        mangaId: mangaId,
                                        title: mangaTitle,
                                        coverURL: coverUrl
                                    )
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
