//
//  SingleViewModelMangaTest.swift
//  mangaqueTests
//
//  Created by Artem Raykh on 03.10.2022.
//

import XCTest
import Nimble
import Quick
import RxSwift
import RxNimble
import RxBlocking
@testable import mangaque

final class SingleViewModelMangaTest: QuickSpec {

    override func spec() {
        super.spec()
        
        var viewModel: SingleMangaViewModel!
        var testItem: MangaViewData!
        
        beforeEach {
            
            testItem = MangaViewData(
                mangaId: "5c9d1254-f074-4b5c-8795-6f0641b2597b",
                title: "Girl and Science",
                coverURL: URL(string: "https://uploads.mangadex.org/covers/5c9d1254-f074-4b5c-8795-6f0641b2597b/b05a86cd-ee5a-4e9a-ada4-b2d789912137.jpg.512.jpg")!
            )
            
            viewModel = SingleMangaViewModel(item: testItem)
        }
        expect(viewModel.redrawChapter())
    }
}
