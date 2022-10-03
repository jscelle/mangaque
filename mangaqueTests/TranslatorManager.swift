//
//  TranslatorManager.swift
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

final class TranslatorManagerTest: QuickSpec {

    override func spec() {
        super.spec()
        
        var translator: TranslatorManager!
        
        beforeEach {
            translator = TranslatorManager()
        }
        
        describe("translotor") {
            it("translated text") {
                
                expect(translator.translate(text: "text"))
                    .first
                    .to(
                        equal("текст")
                    )
            }
        }
    }

}
