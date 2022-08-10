//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

protocol MangaViewModelInterface {
    var updateMangaViewData: ((ViewData<MangaViewDataItem>) -> ())? { get set }
    func startFetch()
}

final class MangaViewModel: MangaViewModelInterface {
    
    private let mangaManager = MangaNetworkManager()
    
    public var updateMangaViewData: ((ViewData<MangaViewDataItem>) -> ())?
    
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
            if error != nil {
                self.updateMangaViewData?(
                    .failure(nil)
                )
            }
            
            if let data = data {
                guard let title = data.data?.first?.attributes?.title?["en"] else {
                    return
                }
                self.updateMangaViewData?(
                    .success(MangaViewDataItem(title: title))
                )
            }
        }
    }
}
