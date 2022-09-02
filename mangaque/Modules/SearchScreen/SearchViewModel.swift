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
    
    //    override func startFetch() {
    //
    //        loading.accept(true)
    //
    //        inputData.subscribe(onNext: { [weak self] text in
    //
    //            guard let self = self else {
    //                return
    //            }
    //
    //            guard let text = text else {
    //                return
    //            }
    //
    //            Task {
    //                let mangaItem = await self.mangaManager.searchManga(title: text)
    //                switch mangaItem {
    //                    case .success(let mangaItem):
    //
    //                        var mangaItems: [MangaViewData] = []
    //
    //                        guard let data = mangaItem.data else {
    //                            return
    //                        }
    //
    //                        await withTaskGroup(of: MangaViewData?.self) { group in
    //
    //                                for dataItem in data {
    //
    //                                    guard let mangaId = dataItem.id else {
    //                                        self.error.accept(MangaErrors.failedToGetManga)
    //                                        break
    //                                    }
    //
    //                                    guard let mangaTitle = dataItem
    //                                        .attributes?
    //                                        .title?
    //                                        .en else {
    //                                        self.error.accept(MangaErrors.failedToGetManga)
    //                                        break
    //                                    }
    //
    //                                    guard let coverId = dataItem
    //                                        .relationships?
    //                                        .first(where: {
    //                                            $0.type == "cover_art" })?
    //                                        .id else {
    //                                        self.error.accept(MangaErrors.failedToGetManga)
    //                                        break
    //                                    }
    //                                    group.addTask {
    //                                        guard let coverUrl = await self.mangaManager.getCoverUrl(
    //                                            coverId: coverId,
    //                                            mangaId: mangaId
    //                                        ) else {
    //                                            self.error.accept(MangaErrors.failedToGetManga)
    //                                            return nil
    //                                        }
    //
    //                                        return MangaViewData(
    //                                            mangaId: mangaId,
    //                                            title: mangaTitle,
    //                                            coverURL: coverUrl
    //                                    )
    //                                }
    //                            }
    //                            for await mangaItem in group {
    //                                if let mangaItem = mangaItem {
    //                                    mangaItems.append(mangaItem)
    //                                }
    //                            }
    //                            self.outputData.accept(mangaItems)
    //                            self.loading.accept(false)
    //                        }
    //                case .failure(let error):
    //                    self.error.accept(error)
    //                }
    //            }
    //        }).disposed(by: disposeBag)
    //    }
    
    override func startFetch() {
        super.startFetch()
        
        mangaManager.getManga().subscribe(
            onNext: { [weak self] manga in
                
                guard let self = self else {
                    return
                }
                
                Task {
                    guard let data = manga.data else {
                        self.error.accept(MangaErrors.failedToGetManga)
                        return
                    }
                    
                    var mangaItems: [MangaViewData] = []
                    
                    await withTaskGroup(of: MangaViewData?.self) { group in
                        
                        for dataItem in data {
                            
                            guard let mangaId = dataItem.id else {
                                self.error.accept(MangaErrors.failedToGetManga)
                                break
                            }
                            
                            guard let mangaTitle = dataItem
                                .attributes?
                                .title?
                                .en else {
                                self.error.accept(MangaErrors.failedToGetManga)
                                break
                            }
                            
                            guard let coverId = dataItem
                                .relationships?
                                .first(where: {
                                    $0.type == "cover_art"
                                })?
                                .id else {
                                self.error.accept(MangaErrors.failedToGetManga)
                                break
                            }
                            group.addTask {
                                guard let coverUrl = await self.mangaManager.getCoverUrl(
                                    coverId: coverId,
                                    mangaId: mangaId
                                ) else {
                                    self.error.accept(MangaErrors.failedToGetManga)
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
                }
            },
            
            onError: { error in
                self.error.accept(error)
            },
            
            onCompleted: { [weak self] in
                self?.loading.accept(false)
            }
            
        ).disposed(by: disposeBag)
    }
}

