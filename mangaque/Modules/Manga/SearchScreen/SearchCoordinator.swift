//
//  SearchNavigator.swift
//  mangaque
//
//  Created by Artem Raykh on 14.09.2022.
//

import UIKit

protocol SearchCoordinatorInterface: Coordinator {
    func singleManga(mangaItem: MangaViewData)
}

//class SearchNavigator: SearchCoordinatorInterface {
//
//    var navigationController: UINavigationController
//
//    func singleManga(mangaItem: MangaViewData) {
//        <#code#>
//    }
//}
