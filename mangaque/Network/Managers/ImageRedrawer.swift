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

#warning("make a translate from language that comes from mangadex api")
class MangaqueManager {
    
    private let disposeBag = DisposeBag()
    private let imageProcessor = MangaqueImageProcessor()
    private let translator = TranslatorManager()
    
    func redrawChapter(pages: [Resource]) -> Single<[UIImage]> {
         return Observable
            .from(pages)
            .flatMap(getImage)
            // MARK: Detect synopsys
            .flatMap(recognizeText)
            // MARK: Translate synopsys
            .concatMap(translate)
            // MARK: Image redraw
            .concatMap(redrawImage)
            .toArray()
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
    
    private func recognizeText(image: UIImage) -> Single<(UIImage, [Synopsis])> {
        imageProcessor
            .getRecognizedText(image: image)
            .map { (image, $0) }
    }
    
    private func redrawImage(
        image: UIImage,
        synopsys: [Synopsis]
    ) -> Single<UIImage> {
        
        return Single.create { single in
            
            let format = UIGraphicsImageRendererFormat()
            format.scale = 1
            
            guard let cgImage = image.cgImage else {
                return Disposables.create()
            }
            
            let size = image.size
            
            let bounds = CGRect(
                origin: .zero,
                size: size
            )
            
                let final = UIGraphicsImageRenderer(
                    bounds: bounds,
                    format: format
                ).image { context in
                    
                    image.draw(in: bounds)
                    
                    for syn in synopsys {
                        
                        let backgroundColor = cgImage.averageColorOf(rect: syn.rect)
                        let textColor = backgroundColor.textColor()
                        
                        self.setupLabel(
                            text: syn.text,
                            backgroundColor: backgroundColor,
                            textColor: textColor,
                            bounds: syn.rect,
                            context: context.cgContext
                        )
                    }
                }
                single(.success(final))
            
            return Disposables.create()
        }
    }
    
    private func translate(
        image: UIImage,
        synopsys: [Synopsis]
    ) -> Observable<(UIImage, [Synopsis])> {
        
        Observable.combineLatest(
            synopsys.map { synopsys in
                translator
                    .translate(text: synopsys.text)
                    .asObservable()
                    .map { Synopsis(text: $0, rect: synopsys.rect) }
            }
        ).map { (image, $0) }
    }
    
    private func setupLabel(
        text: String,
        backgroundColor: UIColor,
        textColor: UIColor,
        bounds: CGRect,
        context: CGContext
    ) {
        let label = UILabel()
        
        label.font = .systemFont(ofSize: 30)
        
        label.adjustsFontSizeToFitWidth = true
        
        label.numberOfLines = 0
        
        label.backgroundColor = backgroundColor
        label.textAlignment = .center
        
        label.bounds = bounds
        
        label.text = text
        label.textColor = textColor
        
        label.layer.render(in: context)
    }
}
