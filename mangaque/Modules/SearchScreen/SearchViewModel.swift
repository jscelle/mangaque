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
    }
    
    private func inputSubscribe() {
        inputData
            .compactMap { $0 }
            .flatMap(searchManga)
            .flatMap(viewData)
            .bind(to: outputData)
            .disposed(by: disposeBag)
    }
    
    private func viewData(json: [JSON]) -> Single<[MangaViewData]> {
        return Observable
            .from(json)
            .compactMap { self.getAttributes(json: $0) }
            .flatMap(getMangaViewData)
            .toArray()
    }
    
    private func searchManga(title: String) -> Maybe<[JSON]> {
        return provider.rx
            .request(.searchManga(title: title))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .compactMap { JSON($0)["data"].array }
    }
    
    private func getAttributes(json: JSON) -> (String, String, String)? {
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
        return (
            title,
            id,
            coverId
        )
    }
    
    private func getMangaViewData(
        title: String,
        id: String,
        coverId: String
    ) -> Maybe<MangaViewData> {
        return provider.rx
            .request(.getMangaCover(coverId: coverId))
            .filterSuccessfulStatusCodes()
            .mapJSON()
            .compactMap {
                
                guard
                    let fileName = JSON($0)["data"]["attributes"]["fileName"].string,
                    let url = Configuration.mangaCoverUrl(
                        mangaId: id,
                        coverFileName: fileName
                    )
                else {
                    return nil
                }
                
                return MangaViewData(
                    mangaId: id,
                    title: title,
                    coverURL: url
                )
        }
    }
}

