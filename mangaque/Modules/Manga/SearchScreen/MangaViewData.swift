//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation
import RxSwift
import RxCocoa
import RxRelay

struct Manga {
    let title: String
    let mangaId: String
    let coverId: String
}

// MARK: Cover is url
struct MangaViewData {
    var mangaId: String
    var title: String
    var coverURL: URL
}

struct SearchInput {
    var text: Observable<String>
}

struct SearchOutput {
    var mangaData: Driver<[MangaViewData]>
}
