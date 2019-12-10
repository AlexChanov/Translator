//
//  TranslateResult.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation
typealias Codable = Decodable & Encodable


/// Server response model
struct TranslationResult: Codable {
    /// translation
    var text: [String]
    /// translation language
    var lang: String
    
}


struct Image : Codable {
    let urls : URLs
}

struct URLs : Codable {
    let small: String
}

class FinalResult {
    
    var tranlationResult: TranslationResult
    var image = [Image]()

    init(translate: TranslationResult, image: [Image]) {
        self.tranlationResult = translate
        self.image = image
    }
    
}

