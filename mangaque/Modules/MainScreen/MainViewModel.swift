//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class MainViewModel: ViewModel<Empty, [MangaViewData]> {
    
    private let mangaManager = MainMangaManager()
    
    #warning("TODO: ALERT CONTROLLER ")
    
    override func startFetch() {
        
        Task {
            let mangaItem = await mangaManager.getManga()
            switch mangaItem {
                case .success(let mangaItem):
                
                    var mangaItems: [MangaViewData] = []
                    
                    guard let data = mangaItem.data else {
                        return
                    }
                
                    await withTaskGroup(of: MangaViewData?.self) { group in
                        
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
                                    
                                    return MangaViewData(
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
                        self.outputData.accept(mangaItems)
                        self.loading.accept(false)
                    }
            case .failure(let error):
                self.error.accept(error)
            }
        }
    }
}
