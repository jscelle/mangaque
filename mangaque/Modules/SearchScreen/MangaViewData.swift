//
//  MangaViewData.swift
//  mangaque
//
//  Created by Artyom Raykh on 10.08.2022.
//

import Foundation

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
