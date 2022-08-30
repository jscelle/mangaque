//
//  SingleMangaViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import Kingfisher

final class SingleMangaViewModel: ViewModel<[PageViewData]> {
    
    private let manager = SingleMangaManager()
    private let item: MainViewData
    
    private var imagePrefetcher: ImagePrefetcher?
    
    init(item: MainViewData) {
        self.item = item
    }
        
    override func startFetch() {
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
                        
                        let urls = chapter.data?.compactMap {
                            Configuration.sourceQualityImageUrl(
                                hash: hash,
                                fileName: $0
                            )
                        }
                        
                        guard let urls = urls else {
                            return
                        }
                        #warning("bug that makes resize images")
                        imagePrefetcher = ImagePrefetcher(
                            urls: urls,
                            completionHandler: { [weak self] skippedResources, failedResources, completedResources in
                                
                                self?.imagePrefetcher?.stop()
                                
                                var resources = skippedResources
                                resources.append(contentsOf: completedResources)
                                
                                print(resources.count)
                                
                                guard let self = self else {
                                    return
                                }
                                
                                let pages = resources.compactMap { resource in
                                    PageViewData(resource: resource)
                                }
                                
                                self.data.onNext(pages)
                                self.loading.onNext(false)
                            }
                        )
                        
                        imagePrefetcher?.start()
                        
                    case .failure(let error):
                        self.error.onNext(error)
                    }
                    
                case .failure(let error):
                    self.error.onNext(error)
                }
            }
        }
    }
}
