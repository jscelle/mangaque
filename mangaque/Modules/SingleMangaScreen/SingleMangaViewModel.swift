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

final class SingleMangaViewModel: ViewModel<Empty, [PageViewData]> {
    
    private let manager = SingleMangaManager()
    private let item: MangaViewData
    
    private var imagePrefetcher: ImagePrefetcher?
    
    init(item: MangaViewData) {
        self.item = item
    }
    
    override func getOutput() {
        super.getOutput()
        
        manager
            .getMangaAppregiate(mangaId: item.mangaId)
            .subscribe { [weak self] aggregate in
                
                guard
                    let self = self,
                    let firstChapterId = aggregate
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
                
                self.manager.getChapterData(chapterId: firstChapterId)
                    .subscribe { chapter in
                        guard let hash = chapter.chapter?.hash else {
                            self.error.accept(MangaErrors.failedToGetImagesUrls)
                            return
                        }
                        
                        guard let chapter = chapter.chapter else {
                            self.error.accept(MangaErrors.failedToGetImagesUrls)
                            return
                        }
                        
                        let urls = chapter.data?.compactMap {
                            Configuration.sourceQualityImageUrl(
                                hash: hash,
                                fileName: $0
                            )
                        }
                        
                        guard let urls = urls else {
                            self.error.accept(MangaErrors.failedToGetImagesUrls)
                            return
                        }
                        
                        self.imagePrefetcher = ImagePrefetcher(
                            urls: urls,
                            completionHandler: { [weak self] skippedResources, failedResources, completedResources in
                                
                                guard
                                    let self = self,
                                    failedResources.isEmpty else {
                                    self?.error.accept(MangaErrors.failedToLoadImages)
                                    return
                                }
                                
                                var resources = skippedResources
                                resources.append(contentsOf: completedResources)
                                
                                print(resources.count)
                                
                                let pages = resources.compactMap { resource in
                                    PageViewData(resource: resource)
                                }
                                
                                self.outputData.accept(pages)
                                self.loading.accept(false)
                            }
                        )
                        
                        self.imagePrefetcher?.start()
                        
                    } onError: { erorr in
                        self.error.accept(MangaErrors.failedToLoadImages)
                    }.disposed(by: self.disposeBag)
                
            } onError: { [weak self] error in
                self?.error.accept(error)
            }.disposed(by: disposeBag)
    }
}
