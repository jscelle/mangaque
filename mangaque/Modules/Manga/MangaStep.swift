//
//  MangaSteps.swift
//  mangaque
//
//  Created by Artem Raykh on 26.09.2022.
//

import RxFlow

enum MangaStep: Step {
    case searchManga
    case singleManga(item: MangaViewData)
}
