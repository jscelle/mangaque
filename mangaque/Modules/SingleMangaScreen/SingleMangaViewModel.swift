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

final class SingleMangaViewModel: ViewModel<Empty, [PageViewData]> {
    
    private let item: MangaViewData
    private let provider = MoyaProvider<SingleMangaAPI>()
    private var imagePrefetcher: ImagePrefetcher?
    private var availableVolumes = [Volume]()
    private var currentChapter = PublishRelay<Chapter>()
    private let mangaqueManager = MangaqueManager()
    
    init(item: MangaViewData) {
        self.item = item
    }
    
    #warning("refactor app so image doesnt redraws in main thread")
    
    override func getOutput() {
        super.getOutput()
        
        provider.rx.request(.getMangaAppregiate(mangaId: item.mangaId))
            .subscribe { [unowned self] response in
            
            do {
                let aggregate = try response.map(AggregateModel.self)
                
                getPages(aggregate: aggregate)
                
            } catch {
                outputData.onError(error)
            }
            
        } onFailure: { [unowned self] error in
            outputData.onError(error)
        }.disposed(by: disposeBag)
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
        
        drawChapter()
        
        currentChapter.accept(ch)
    }
    
    private func drawChapter() {
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
            .flatMap(downloadImages)
            .flatMap(self.mangaqueManager.redrawChapter)
            .compactMap {
                $0.compactMap {
                    PageViewData(image: $0)
                }
            }
           .bind(to: outputData)
           .disposed(by: disposeBag)
    }
    
    private func downloadImages(urls: [URL]) -> Single<[Resource]> {
        
        return Single.create { single in
            
            let disposables = Disposables.create()
            
            self.imagePrefetcher = ImagePrefetcher(
                resources: urls,
                options: .none
            ) { skippedResources, failedResources, completedResources in
                
                if failedResources.isEmpty {
                    let viewData = (skippedResources + completedResources)
                    single(.success(viewData))
                }
                
                self.imagePrefetcher?.stop()
            }
            
            self.imagePrefetcher?.start()
            
            return disposables
        }
    }
    
    private func getChapterData(id: String) -> Single<ChapterDataModel> {
        
        return Single.create { single in
            
            let disposables = Disposables.create()
            
            self.provider.request(.getChapterData(chapterId: id)) { result in
                switch result {
                case .success(let response):
                    do {
                        
                        let data = try response.map(ChapterDataModel.self)
                        
                        single(.success(data))
                    } catch {
                        single(.failure(error))
                    }
                case .failure(let error):
                    single(.failure(error))
                }
            }
            return disposables
        }
    }
}
