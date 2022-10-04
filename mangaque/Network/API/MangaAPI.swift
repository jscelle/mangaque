//
//  MangaAPI.swift
//  mangaque
//
//  Created by Artem Raykh on 04.09.2022.
//

import Moya

struct MangaAPI: TargetType {
    let baseURL: URL = URL(string: Configuration.mangaApiUrl)!
    let path: String
    let method: Moya.Method
    let task: Task
    let headers: [String : String]?
}

extension MangaAPI {
    static let getManga = MangaAPI(
        path: "/manga",
        method: .get,
        task: .requestPlain,
        headers: nil
    )
    
    static let getRandomManga = MangaAPI(
        path: "/manga/random",
        method: .get,
        task: .requestPlain,
        headers: nil
    )
    
    static func searchManga(title: String) -> MangaAPI {
        MangaAPI(
            path: "/manga",
            method: .get,
            task: .requestParameters(
                parameters: ["title": title],
                encoding: URLEncoding.queryString
            ),
            headers: nil
        )
    }
    
    static func getMangaCover(coverId: String) -> MangaAPI {
        MangaAPI(
            path: "/cover\(coverId)",
            method: .get,
            task: .requestPlain,
            headers: nil
        )
    }
    
    static func getMangaAggregate(mangaId: String) -> MangaAPI {
        MangaAPI(
            path: "/manga/\(mangaId)/aggregate",
            method: .get,
            task: .requestPlain,
            headers: nil
        )
    }
}
