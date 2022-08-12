//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

protocol MangaViewModelInterface {
    var updateMangaViewData: ((ViewData<[MangaViewDataItem]>) -> ())? { get set }
    func startFetch()
}

enum MangaErrors: Error {
    case failedToGetId
    case failedToGetTitle
    case failedToGetCoverUrl
}

final class MangaViewModel: MangaViewModelInterface {
    
    private let mangaManager = MangaNetworkManager()
    
    public var updateMangaViewData: ((ViewData<[MangaViewDataItem]>) -> ())?
    
    init() {
        updateMangaViewData?(.initial)
    }
    
    #warning("TODO: ALERT CONTROLLER ")
    func startFetch() {
        
        mangaManager.getManga { [weak self] data, error in
            
            guard let self = self else {
                return
            }
            
            #warning("error handler")
            if let error = error {
                self.updateMangaViewData?(.failure(error))
            }

            if let data = data?.data {
                do {
                    let mangaItems: [MangaViewDataItem] = try data.compactMap { data in
                        
                        guard let id = data.id else {
                            throw MangaErrors.failedToGetId
                        }
                        
                        guard let title = data.attributes?.title?["en"] else {
                            throw MangaErrors.failedToGetTitle
                        }
                        
                        guard let coverUrl = URL(string: Configuration.mangaApiUrl + "/cover/\(id)") else {
                            throw MangaErrors.failedToGetCoverUrl
                        }
                        
                        return MangaViewDataItem(
                            mangaId: id,
                            title: title,
                            coverURL: coverUrl
                        )
                    }
                    
                    self.updateMangaViewData?(.success(mangaItems))
                } catch let error {
                    self.updateMangaViewData?(.failure(error))
                }
            }
        }
    }
}