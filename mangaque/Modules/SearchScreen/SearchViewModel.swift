//
//  SearchViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class SearchViewModel: ViewModel<String?, [MangaViewData]> {
    
    private let mangaManager = MainMangaManager()
    
    override func startFetch() {
        super.startFetch()
        
        inputSubscribe()
        
        mangaManager.getManga().subscribe { [weak self] manga in
                
                guard let self = self else {
                    return
                }
                self.getMangaItems(manga: manga)
            }
            
            onError: { error in
                self.error.accept(error)
            }
            
            onCompleted: { [weak self] in
                self?.loading.accept(false)
            }.disposed(by: disposeBag)
    }
    
    private func inputSubscribe() {
        
        inputData.subscribe { [weak self] text in
            guard
                let text = text,
                let self = self
            else {
                return
            }
            
            self.mangaManager.searchManga(title: text).subscribe { [weak self] manga in
                self?.getMangaItems(manga: manga)
            } onError: { error in
                self.error.accept(error)
            }.disposed(by: self.disposeBag)
            
            
        } onError: { [weak self] error in
            self?.error.accept(error)
        } onCompleted: { [weak self] in
            self?.loading.accept(false)
        }.disposed(by: disposeBag)
    }
    
    private func getMangaItems(manga: MangaModel) {
        
        Task {
            guard let data = manga.data else {
                error.accept(MangaErrors.failedToGetManga)
                return
            }
            
            var mangaItems: [MangaViewData] = []
            
            await withTaskGroup(of: MangaViewData?.self) { group in
                
                for dataItem in data {
                    
                    guard let mangaId = dataItem.id else {
                        error.accept(MangaErrors.failedToGetManga)
                        break
                    }
                    
                    guard let mangaTitle = dataItem
                        .attributes?
                        .title?
                        .en
                    else {
                        error.accept(MangaErrors.failedToGetManga)
                        break
                    }
                    
                    guard let coverId = dataItem
                        .relationships?
                        .first(where: {
                            $0.type == "cover_art"
                        })?
                        .id
                    else {
                        error.accept(MangaErrors.failedToGetManga)
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
                outputData.accept(mangaItems)
                loading.accept(false)
            }
        }
    }
}

