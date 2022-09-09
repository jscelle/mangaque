//
//  SearchViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 30.08.2022.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import SwiftyJSON

final class SearchViewModel: ViewModel<String?, [MangaViewData]> {
    
    private let provider = MoyaProvider<MangaAPI>()
    
    override func getOutput() {
        super.getOutput()
        
        //inputSubscribe()
        
        provider.request(.getManga) { [weak self] result in
            
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let response):
                do {
                    let data = try response.mapJSON()
                    
                    guard let dataArray = JSON(data)["data"].array else {
                        return
                        
                    }
                    
                    self.getManga(json: dataArray)
                    
                } catch {
                    self.outputData.onError(error)
                }
            case .failure(let error):
                self.outputData.onError(error)
                break
            }
        }
    }
    
    private func inputSubscribe() {
        
        inputData.subscribe (onNext: { [unowned self] text in
            guard let text = text else {
                return
            }
            
            self.provider.rx.request(.searchManga(title: text))
                .subscribe { [unowned self] response in
                    
                    do {
                        let data = try response.mapJSON()
                        
                        guard let json = JSON(data)["data"].array else {
                            return
                        }
                        
                        getManga(json: json)
                        
                    } catch {
                        outputData.onError(error)
                        outputData.onCompleted()
                    }
                } onFailure: { [unowned self] error in
                    
                    outputData.onError(error)
                    outputData.onCompleted()
                    
                }.disposed(by: disposeBag)
            
        }).disposed(by: disposeBag)
    }
    
    
    private func getManga(json: [JSON]) {
        
        Observable.from(json)
            .compactMap { json -> Manga? in
                let title = json["attributes"]["title"]["en"].string
                
                let coverId = json["relationships"]
                    .array?
                    .filter { $0["type"].string == "cover_art" }
                    .compactMap { $0["id"].string }
                    .first
                
                let id = json["id"].string
                
                guard
                    let title = title,
                    let coverId = coverId,
                    let id = id
                else {
                    return nil
                }
                #warning("refactor this model")
                return Manga(
                    title: title,
                    mangaId: id,
                    coverId: coverId
                )
            }
            .flatMap(getMangaViewData)
            .toArray()
            .subscribe(on: SerialDispatchQueueScheduler(qos: .background))
            .subscribe({ [unowned self] manga in
                
                switch manga {
                case .success(let manga):
                    self.outputData.onNext(manga)
                case .failure(let error):
                    self.outputData.onError(error)
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func getMangaViewData(manga: Manga) -> Single<MangaViewData> {
        
        return Single.create { [unowned self] single in
            
            provider.request(.getMangaCover(coverId: manga.coverId)) { result in
                
                switch result {
                    
                case .success(let response):
                    
                    do {
                        let coverData = try response.mapJSON()
                        
                        guard
                            let fileName = JSON(coverData)["data"]["attributes"]["fileName"].string,
                            let url = Configuration.mangaCoverUrl(
                                mangaId: manga.mangaId,
                                coverFileName: fileName
                            )
                        else {
                            break
                        }
                        
                        let viewData = MangaViewData(
                            mangaId: manga.mangaId,
                            title: manga.title,
                            coverURL: url
                        )
                        
                        single(.success(viewData))
                        
                    } catch {
                        single(.failure(error))
                    }
                    
                case .failure(let error):
                    single(.failure(error))
                }
            }
                        
            return Disposables.create()
        }
    }
}

