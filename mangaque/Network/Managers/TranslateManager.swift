//
//  TranslateManager.swift
//  mangaque
//
//  Created by Artem Raykh on 31.08.2022.
//

import Foundation

final class TranslateManager: BaseNetworkManager {
    
    func detectLanguage(text: String) async -> Result<EmptyResponse, Error> {
        return await request(route: TranslatorAPIRouter.detectLanguage(text: text))
    }
}
