//
//  SingleMangaViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation

protocol SingleMangaViewModelInterface {
    var updateViewData: ((_ item: ViewData<Chapter>) -> ())? { get set }
    func startFetch()
}

final class SingleMangaViewModel: SingleMangaViewModelInterface {
    
    private let manager = SingleMangaManager()
    private let item: MangaViewDataItem
    
    init(item: MangaViewDataItem) {
        self.item = item
    }
    
    var updateViewData: ((_ item: ViewData<Chapter>) -> ())?
    
    func startFetch() {
        Task {
            do {
                let response = await manager.getMangaAppregiate(mangaId: item.mangaId)
                
                switch response {
                case .success(let aggregate):
                    
                    guard let firstChapter = aggregate
                        .volumes?
                        .first(where: {  $0.key == "1"})?
                        .value
                        .chapters?
                        .first(where: { $0.key == "1" })?
                        .value
                    else {
                        return
                    }
                    updateViewData?(.success(firstChapter))
                    
                case .failure(let error):
                    print(error)
                    updateViewData?(.failure(error))
                }
            }
        }
    }
}
