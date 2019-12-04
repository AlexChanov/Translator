//
//  APIWrapper.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation

struct APIWrapper {
    
    
    let baseURL = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    // Hope github hackers won't use it
    let token = "trnsl.1.1.20191102T164221Z.cb1eb57036a33b58.9072f15ac51c5398e32a2e5a18aee25ec8035199"
    
    
    struct Constants {
        static let baseUrl = "https://api.unsplash.com"
        static let searchPath = "/photos/random"
        static let client_id = "f21996f497d5458c61d2f4b8fbb066f264fcefd2b8c1cca4f5d15cfdd2e9239e"
        static let orientation = "portrait"
        static let count = 30
    }
}
