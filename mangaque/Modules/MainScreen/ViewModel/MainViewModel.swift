//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class MainViewModel: ViewModel {
    
    var data: BehaviorRelay<ViewData<[MainViewData]>>
    
    private let mangaManager = MainMangaManager()
        
    init() {
        data = BehaviorRelay(value: .initial)
    }
    
    #warning("TODO: ALERT CONTROLLER ")
    
    func startFetch() {
        Task {
            data.accept(.loading)
            let mangaItem = await mangaManager.getManga()
            switch mangaItem {
                case .success(let mangaItem):
                
                    var mangaItems: [MainViewData] = []
                    
                    guard let data = mangaItem.data else {
                        return
                    }
                
                    await withTaskGroup(of: MainViewData?.self) { group in
                        
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
                                    
                                    return MainViewData(
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
                        self.data.accept(.success(mangaItems))
                    }
            case .failure(let error):
            #warning("error handler")
                self.data.accept(.failure(error))
            }
        }
    }
}
