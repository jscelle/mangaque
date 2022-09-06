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
import Moya

final class SingleMangaViewModel: ViewModel<Empty, [PageViewData]> {
    
    private let item: MangaViewData
    
    private let provider = MoyaProvider<SingleMangaAPI>()
    
    private var imagePrefetcher: ImagePrefetcher?
    
    private var availableVolumes = [Volume]()
    
    private var currentChapter = PublishRelay<Chapter>()
    
    init(item: MangaViewData) {
        self.item = item
    }
    
    override func getOutput() {
        super.getOutput()
        
        provider.rx.request(.getMangaAppregiate(
                mangaId: item.mangaId
            )
        ).subscribe { [unowned self] response in
            
            do {
                let aggregate = try response.map(AggregateModel.self)
                
                self.getPages(aggregate: aggregate)
                
            } catch {
                self.outputData.onError(error)
            }
            
        } onFailure: { [unowned self] error in
            self.outputData.onError(error)
        }.disposed(by: disposeBag)
    }
    
    private func getPages(aggregate: AggregateModel) {
        
        let volumes = aggregate.volumes?.values.compactMap{ $0 as Volume }
        
        guard let volumes = volumes else {
            return
        }
        
        availableVolumes = volumes
        
        guard let ch = availableVolumes.first?.chapters?.first?.value else {
            return
        }
        
        drawChapter()
        
        self.currentChapter.accept(ch)
        
    }
    
    private func drawChapter() {
        
        currentChapter.subscribe(onNext: { [unowned self] chapter in
            
            guard let id = chapter.id else {
                self.outputData.onError(MangaErrors.failedToLoad(stage: .getPages))
                return
            }
            
            self.provider.rx.request(
                .getChapterData(chapterId: id)
            ).subscribe { [unowned self] response in
                
                do {
                    let chapterData = try response.map(ChapterDataModel.self)
                    
                    guard
                        let hash = chapterData.chapter?.hash,
                        let chapterPages = chapterData.chapter?.data
                    else {
                        self.outputData.onError(MangaErrors.failedToLoad(stage: .getPages))
                        self.outputData.onCompleted()
                        return
                    }
                    
                    let urls = chapterPages.compactMap { data in
                        Configuration.sourceQualityImageUrl(hash: hash, fileName: data)
                    }
                    
                    self.imagePrefetcher = ImagePrefetcher(
                        urls: urls,
                        completionHandler: { [unowned self] skippedResources, failedResources, completedResources in
                            
                            guard failedResources.isEmpty else {
                                self.outputData.onError(MangaErrors.failedToLoad(stage: .getPages))
                                self.outputData.onCompleted()
                                return
                            }
                            
                            var resources = skippedResources
                            resources.append(contentsOf: completedResources)
                            
                            print(resources.count)
                            
                            let pages = resources.compactMap { resource in
                                PageViewData(resource: resource)
                            }
                            
                            self.outputData.onNext(pages)
                            self.outputData.onCompleted()
                        }
                    )
                    
                    self.imagePrefetcher?.start()
                   
                    
                } catch {
                    self.outputData.onError(MangaErrors.failedToLoad(stage: .getPages))
                    self.outputData.onCompleted()
                }
                
            } onFailure: { [unowned self] error in
                self.outputData.onError(error)
                self.outputData.onCompleted()
            }.disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)

    }
}
