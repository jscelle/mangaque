//
//  TranslatorManager.swift
//  mangaque
//
//  Created by Artem Raykh on 11.09.2022.
//

import Foundation
import MangaqueImage
import SwiftyJSON
import Moya

#warning("make mangaqueImage rx")
class TranslatorManager: MangaqueTranslator {
    
    private let provider = MoyaProvider<TranslotorAPI>()
    
    func performTranslate(
        untranslatedText: String,
        comletionHandler: @escaping (String?, Error?) -> ()
    ) {
        
        
        
        provider.request(.translate(text: untranslatedText)) { result in
            
            switch result {
            case .success(let response):
                do {
                    let data = try response.mapJSON()
                    guard let translatedText = JSON(data)["translations"].array else {
                        return
                    }
                    
                    comletionHandler("translate", nil)
                    
                    print(translatedText)
                    
                } catch {
                    comletionHandler(nil, error)
                }
            case .failure(let error):
                comletionHandler(nil, error)
            }
            
        }
    }
}
