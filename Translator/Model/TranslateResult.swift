//
//  TranslateResult.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation

/// Server response model
class TranslationResult: Decodable {
    /// translation
    var text: [String]
    /// translation language
    var lang: String
}
