//
//  TranslatorManager.swift
//  mangaque
//
//  Created by Artem Raykh on 11.09.2022.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import Moya

#warning("make languages to choose from, pass original chapter language throught trasnlator rx")
class TranslatorManager {
    
    private let provider = MoyaProvider<TranslatorAPI>()
    
    func translate(
        text: String
    ) -> Observable<String> {
        
        return provider.rx
            .request(.translate(text: text))
            .mapJSON()
            .compactMap {
                guard let text = JSON($0)["translations"].array?.first?["text"].string else {
                    return nil
                }
                return text
            }
            .asObservable()
    }
}
