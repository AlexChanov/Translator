//
//  TranslatorTests.swift
//  TranslatorTests
//
//  Created by Алексей ]Чанов on 10/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import XCTest
@testable import Translator


class TranslatorTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
    }

    override func tearDown() {
        super.tearDown()
    }
 
    
    func testAddNewElementInBeginningOfArray() {
        let sut = MainViewController()
        var testArray = [1,2,3]
        let newElement = 4
        sut.addElementToArrayInReverseOrder(array: &testArray, newElement: newElement)
        
        XCTAssert(testArray.first == newElement, "Add element in array it works incorrectly")
    }
    
    
    func testGetImageUrlObject() {
        
        let translate = Storage.saveTranslateInfo(wordForTranslate: "Test", translatedWord: "Test")
        XCTAssert(translate != nil, "We get nil in CoreData save")
    }

    
    func testGetObjectFinalResult() {
        
        let sut = NewTranslatedWordViewController()
        sut.setDataforCell(data: FinalResult(translate: TranslationResult(text: ["awesome text"], lang: "awesomeLang"), image: [Image(urls: URLs(small: "awesome url"))]), wordforTranlate: "awesome word")
        XCTAssertNotNil(sut.dataForFilligCell)
    }
}
