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
        
        inputSubscribe()
        
        provider.rx.request(.getManga).subscribe { [weak self] response in
            
            guard let self = self else {
                return
            }
            
            do {
                let data = try response.mapJSON()
                self.getMangaData(
                    json: JSON(
                        data
                    )
                )
            } catch {
                self.error.accept(error)
            }
            
        } onFailure: { [weak self] error in
            self?.error.accept(error)
        }.disposed(by: disposeBag)
        
    }
    
    private func inputSubscribe() {
        
        inputData.subscribe (onNext: { [weak self] text in
            guard
                let text = text,
                let self = self
            else {
                return
            }
            
            self.provider.rx.request(.searchManga(title: text))
                .subscribe { [weak self] response in
                    
                    guard let self = self else {
                        return
                    }
                    
                    do {
                        let data = try response.mapJSON()
                        self.getMangaData(
                            json: JSON(
                                data
                            )
                        )
                    } catch {
                        self.error.accept(error)
                    }
                } onFailure: { [weak self] error in
                    self?.error.accept(error)
                }.disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
    }
    
    private func getMangaData(json: JSON) {
        
        let json = json["data"].array
        
        let group = DispatchGroup()
        
        var manga = [MangaViewData]()
        
        json?.forEach { json in
            
            group.enter()
            
            guard
                let id = json["id"].string,
                let title = json["attributes"]["title"]["en"].string
            else {
                self.error.accept(MangaErrors.failedToLoad(stage: .getManga))
                return
            }
            
            let coverId = json["relationships"]
                .array?
                .filter { $0["type"].string == "cover_art" }
                .compactMap { $0["id"].string }
                .first
            
            guard let coverId = coverId else {
                return
            }
            
            self.provider.rx.request(.getMangaCover(coverId: coverId))
                .subscribe { [weak self] response in
                    
                    guard let self = self else {
                        return
                    }
                    
                    do {
                        let coverData = try response.mapJSON()
                        
                        guard
                            let fileName = JSON(coverData)["data"]["attributes"]["fileName"].string,
                            let url = Configuration.mangaCoverUrl(
                                mangaId: id,
                                coverFileName: fileName
                            )
                        else {
                            self.error.accept(MangaErrors.failedToLoad(stage: .getThumbnail))
                            return
                        }
                        
                        manga.append(
                            MangaViewData(
                                mangaId: id,
                                title: title,
                                coverURL: url
                            )
                        )
                        
                    } catch {
                        self.error.accept(error)
                    }
                    
                    group.leave()
                    
                } onFailure: { [weak self] error in
                    self?.error.accept(error)
                    group.leave()
                }.disposed(by: self.disposeBag)
        }
        
        group.notify(queue: .main) {
            self.outputData.accept(manga)
        }
    }
}

