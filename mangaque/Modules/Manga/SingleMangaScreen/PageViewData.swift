//
//  SingleMangaViewModel.swift
//  mangaque
//
//  Created by Artem Raykh on 17.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

struct PageViewData {
    let image: UIImage
}

struct SingleMangaOutput {
    let page: Driver<[PageViewData]>
}
