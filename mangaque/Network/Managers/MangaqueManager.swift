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
    
    private let mangaque = MangaqueImage()
    private let disposeBag = DisposeBag()
    
    func redrawChapter(pages: [Resource]) -> Single<[UIImage]> {
        
        return Observable
            .from(pages)
            .flatMap(getImage)
            .flatMap(redrawImage)
            .toArray()
            .flatMap { Single.just($0) }
            
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
    
    private func redrawImage(image: UIImage) -> Single <UIImage> {
        return Single.create { [unowned self] single in
            
            let disposables = Disposables.create()
            
            mangaque.redrawImage(
                image: image,
                translator: .none,
                textColor: .auto,
                backgroundColor: .auto
            ) { image, error in
                    
                if let error = error {
                    single(.failure(error))
                }
                
                if let image = image {
                    single(.success(image))
                }
            }
            
            return disposables
        }
    }
}
