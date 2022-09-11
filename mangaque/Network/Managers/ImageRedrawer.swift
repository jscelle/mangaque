//
//  MangaqueManager.swift
//  mangaque
//
//  Created by Artem Raykh on 09.09.2022.
//

import Foundation
import MangaqueImage
import Kingfisher
import RxSwift

class MangaqueManager {
    
    private let disposeBag = DisposeBag()
    private let imageProcessor = MangaqueImageProcessor()
    
    func redrawChapter(pages: [Resource]) {
        
        Observable
            .from(pages)
            .flatMap(getImage)
            .flatMap(imageProcessor.getRecognizedText)
            
//            .flatMap(redrawImage)
//            .toArray()
//            .flatMap { Single.just($0) }
    }
    
    private func getImage(resource: Resource) -> Single<UIImage> {
        return Single.create { single in
            let disposables = Disposables.create()
            
            KingfisherManager.shared.retrieveImage(with: resource) { result in
                
                switch result {
                    
                case .success(let value):
                    single(.success(value.image))
                case .failure(let error):
                    single(.failure(error))
                }
            }
            
            return disposables
        }
    }
    
    private func redrawImage() {
        
    }
}
