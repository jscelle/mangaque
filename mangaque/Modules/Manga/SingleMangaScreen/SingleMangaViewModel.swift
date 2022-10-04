//
//  SingleMangaViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation
import RxCocoa
import RxSwift
import Kingfisher
import Moya

final class SingleMangaViewModel: ViewModel, ViewModelType {
    
    private let item: MangaViewData
    private let provider = MoyaProvider<SingleMangaAPI>()
    private var imagePrefetcher: ImagePrefetcher?
    private var availableVolumes = [Volume]()
    private var currentChapter = PublishRelay<Chapter>()
    private let mangaqueManager = ImageRedrawer()
    
    init(item: MangaViewData) {
        self.item = item
    }
    
    func transform(input: Empty? = nil) -> SingleMangaOutput {
        
        let chapter = redrawedChapter()
        
        print(item)
        
        provider
            .rx
            .request(.getMangaAppregiate(mangaId: item.mangaId))
            .filterSuccessfulStatusCodes()
            .map(AggregateModel.self)
            .asObservable()
            .flatMap(getChapter)
            .bind(to: currentChapter)
            .disposed(by: disposeBag)
        
        return SingleMangaOutput(page: chapter)
    }
    
    private func getChapter(aggregate: AggregateModel) -> Single<Chapter> {
        
        Single.create { single in
            
            let disposables = Disposables.create()
            
            let volumes = aggregate.volumes?.values.compactMap{ $0 as Volume }
            
            guard let volumes = volumes else {
                return disposables
            }
            
            guard let chapter = volumes.first?.chapters?.first?.value else {
                return disposables
            }
            
            single(.success(chapter))
            
            return Disposables.create()
        }
    }
    
    #warning("refactor this")
    private func getPages(aggregate: AggregateModel) {
        
        let volumes = aggregate.volumes?.values.compactMap{ $0 as Volume }
        
        guard let volumes = volumes else {
            return
        }
        
        availableVolumes = volumes
        
        guard let ch = availableVolumes.first?.chapters?.first?.value else {
            return
        }
        
        currentChapter.accept(ch)
    }
    
    private func redrawedChapter() -> Driver<[PageViewData]> {
        currentChapter
            .compactMap { $0.id }
            .flatMap(getChapterData)
            .compactMap { chapter -> [URL]? in
                guard
                    let data = chapter.chapter,
                    let hash = data.hash,
                    let data = data.data
                else {
                    return nil
                }
                
                return data.compactMap { fileName in
                    return Configuration.sourceQualityImageUrl(
                        hash: hash,
                        fileName: fileName
                    )
                }
            }
            .compactMap {
                $0.compactMap {
                    ImageResource(downloadURL: $0)
                }
            }
            .concatMap(self.mangaqueManager.redrawChapter)
            .compactMap {
                $0.compactMap {
                    PageViewData(image: $0)
                }
            }
           .asDriver(onErrorJustReturn: [])
    }
    
    func redrawChapter() {
        currentChapter
            .compactMap { $0.id }
            .subscribe(onNext: {
                print($0.count)
            })
    }
    
    private func getChapterData(id: String) -> Observable<ChapterDataModel> {
        
        provider
            .rx
            .request(.getChapterData(chapterId: id))
            .map(ChapterDataModel.self)
            .asObservable()
    }
}
