//
//  SearchViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

class SearchViewModel: ViewModel<String?, [MangaViewData]> {
    
    private let mangaManager = MainMangaManager()

    override func startFetch() {
        
        loading.accept(true)
        
        inputData.subscribe(onNext: { [weak self] text in
            
            guard let self = self else {
                return
            }
            
            guard let text = text else {
                return
            }
            
            Task {
                let mangaItem = await self.mangaManager.searchManga(title: text)
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
        }).disposed(by: disposeBag)
    }
}
