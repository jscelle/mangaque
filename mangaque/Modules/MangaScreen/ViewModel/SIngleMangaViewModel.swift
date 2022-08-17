//
//  SIngleMangaViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation

protocol SingleMangaViewModelInterface {
    var updateViewData: (() -> ())? { get set }
    func startFetch()
}

final class SingleMangaViewModel: SingleMangaViewModelInterface {
    
    private let manager = SingleMangaManager()
    private let item: MangaViewDataItem
    
    init(item: MangaViewDataItem) {
        self.item = item
    }
    
    var updateViewData: (() -> ())?
    
    func startFetch() {
        Task {
            do {
                let response = await manager.getMangaAppregiate(mangaId: item.mangaId)
                print(response)
            }
            
        }
    }
}
