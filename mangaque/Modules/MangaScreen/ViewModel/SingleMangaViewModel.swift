//
//  SingleMangaViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation
import UIKit
import CollectionConcurrencyKit

protocol SingleMangaViewModelInterface {
    var updateViewData: ((_ item: ViewData<PagesViewData>) -> ())? { get set }
    func startFetch()
}

#warning("rewrite anything to rxswift")
final class SingleMangaViewModel: SingleMangaViewModelInterface {
    
    private let manager = SingleMangaManager()
    private let item: MainViewData
    
    init(item: MainViewData) {
        self.item = item
    }
    
    var updateViewData: ((_ item: ViewData<PagesViewData>) -> ())?
    
    func startFetch() {
        Task {
            do {
                let response = await manager.getMangaAppregiate(mangaId: item.mangaId)
                
                switch response {
                case .success(let aggregate):
                    guard let firstChapterId = aggregate
                        .volumes?
                        .first?
                        .value
                        .chapters?
                        .first(where: { $0.key == "1" })?
                        .value
                        .id
                    else {
                        return
                    }
                    
                    let pages = await manager.getChapterData(chapterId: firstChapterId)
                    
                    switch pages {
                    case .success(let chapter):
                        
                        guard let hash = chapter.chapter?.hash else {
                            break
                        }
                        
                        guard let chapter = chapter.chapter else {
                            return
                        }
                        #warning("make sure it is the fastest method to do it")
                        #warning("no for sure :)")
                        let imagesData = await chapter.data?.asyncCompactMap { fileName -> Data? in
                            let imageResponse = await manager.getImageData(hash: hash, fileName: fileName)
                            
                            switch imageResponse {
                            case .success(let data):
                                return data
                            case .failure(let error):
                                print(error)
                                break
                            }
                            return nil
                        }
                        
                        updateViewData?(.success(
                            PagesViewData(
                                pageImages: imagesData ?? []
                            )
                        ))
                    case .failure(let error):
                        updateViewData?(.failure(error))
                    }
                    
                case .failure(let error):
                    print(error)
                    updateViewData?(.failure(error))
                }
            }
        }
    }
}
