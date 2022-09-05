//
//  SingleMangaAPI.swift
//  mangaque
//
//  Created by Artem Raykh on 04.09.2022.
//

import Moya

enum SingleMangaAPI {
    case getMangaAppregiate(mangaId: String)
    case getChapterData(chapterId: String)
}

extension SingleMangaAPI: TargetType {
    
    var baseURL: URL {
        return URL(string: Configuration.mangaApiUrl)!
    }
    
    var path: String {
        switch self {
        case .getMangaAppregiate(let mangaId):
            return "/manga/\(mangaId)/aggregate"
        case .getChapterData(chapterId: let chapterId):
            return "/at-home/server/\(chapterId)"
        }
    }
    
    var method: Method {
        return .get
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
