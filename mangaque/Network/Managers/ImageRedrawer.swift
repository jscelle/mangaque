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
        
        let image = Observable.from(pages)
            .concatMap(getImage)

        let translatedSynopses = image
            .flatMap(imageProcessor.getRecognizedText)
            .concatMap { Single.zip($0.map(self.translate)) }

        return Observable.zip(image, translatedSynopses)
            .compactMap(redrawImage)
            .toArray()
    }

    func getImage(resource: Resource) -> Single<UIImage> {
        
        Single.create { single in
            
            KingfisherManager.shared.retrieveImage(with: resource) { result in
                switch result {
                    case .success(let value):
                        single(.success(value.image))
                    case .failure(let error):
                        single(.failure(error))
                }
            }
            return Disposables.create()
        }
    }

    func translate(synopses: Synopsis) -> Single<Synopsis> {
        
        translator.translate(text: synopses.text)
            .map { Synopsis(text: $0, rect: synopses.rect) }
            .asSingle()
    }

    func redrawImage(image: UIImage, synopses: [Synopsis]) -> UIImage? {
        guard let cgImage = image.cgImage else { return nil }
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        let size = image.size
        let bounds = CGRect(origin: .zero, size: size)

        return UIGraphicsImageRenderer(bounds: bounds, format: format).image { context in
            image.draw(in: bounds)
            for syn in synopses {
                let backgroundColor = ColorManager(image: cgImage).averageColor(of: syn.rect)
                let textColor = backgroundColor.textColor()
                setupLabel(
                    text: syn.text,
                    backgroundColor: backgroundColor,
                    textColor: textColor,
                    bounds: syn.rect,
                    context: context.cgContext
                )
            }
        }
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
