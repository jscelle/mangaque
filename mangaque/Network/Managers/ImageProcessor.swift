//
//  MangaqueImage.swift
//  mangaque
//
//  Created by Artem Raykh on 11.09.2022.
//

import UIKit
import RxCocoa
import RxSwift
import Vision

final class MangaqueImageProcessor {
    
    func getRecognizedText(image: UIImage) -> Single<[Synopsis]> {
        
        return Single.create { [unowned self] single in
            
            let disposables = Disposables.create()
            
            guard let cgImage = image.cgImage else {
                return disposables
            }
            
            let size = CGSize(
                width: cgImage.width,
                height: cgImage.height
            )
            
            let imageRequestHandler = VNImageRequestHandler(
                cgImage: cgImage,
                orientation: .up
            )
            
            let request = VNRecognizeTextRequest { request, error in
                
                // MARK: Text detection
                if let error = error {
                    single(.failure(error))
                }
                guard let results = request.results as? [VNRecognizedTextObservation] else {
                    return
                }
                
                // MARK: Converting to synopsis
                let synopsisArray = results.compactMap { observation -> Synopsis? in
                    
                    let rect = observation.boundingBox.convert(
                        to: CGRect(
                            origin: .zero,
                            size: size
                        )
                    )
                    
                    guard let text = observation.topCandidates(1).first?.string else {
                        return nil
                    }
                    
                    return Synopsis(
                        text: text,
                        rect: rect
                    )
                }
                
                let groupedArray = self.groupCloseSynopsis(synopisArray: synopsisArray)
                
                single(.success(groupedArray))
            }
            
            do {
                try imageRequestHandler.perform([request])
            } catch {
                single(.failure(error))
            }
            
            return disposables
        }
    }
    
    // MARK: Grouping close synopsises
    private func groupCloseSynopsis(
        synopisArray: [Synopsis]
    ) -> [Synopsis] {
        
        // MARK: Grouping array by x and y coordinates
        let sortedArray = synopisArray.sorted { first, second in
            first.rect.midX > second.rect.midX
        }
        .grouped { first, second in
            let differenceX = abs(first.rect.midX - second.rect.midX)
            let offsetX = min(first.rect.width, second.rect.width) / 4
                
            return differenceX < offsetX
        }
        .compactMap { array in
            array.sorted { first, second in
                first.rect.midY < second.rect.midY
            }
        }
        .compactMap { array in
            array.grouped { first, second in
                return first.rect.midY - second.rect.midY < 300
            }
        }
        .joined()
        
        let unitedArray = sortedArray.compactMap { array -> Synopsis? in
            let text = array.compactMap {
                $0.text
            }
            .joined(separator: "\n")
            
            let rect = array.reduce(CGRect.null) {
                $0.union($1.rect)
            }
            
            return Synopsis(
                text: text,
                rect: rect
            )
        }
        return unitedArray
    }
}
