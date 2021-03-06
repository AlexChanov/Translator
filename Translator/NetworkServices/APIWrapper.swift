//
//  APIWrapper.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation

struct APIWrapper {
    
    // URL components for get translate
    // Hope github hackers won't use it
    private let baseURL = "https://translate.yandex.net/api/v1.5/tr.json/translate"
    private let token = "trnsl.1.1.20191102T164221Z.cb1eb57036a33b58.9072f15ac51c5398e32a2e5a18aee25ec8035199"
    
    // URL components for get image
    private let baseUrlforImage = "https://api.unsplash.com/photos/random"
    private let client_id = "f21996f497d5458c61d2f4b8fbb066f264fcefd2b8c1cca4f5d15cfdd2e9239e"
    private let orientationImage = "portrait"
    private let countImage = "4"
    
    
     func makeUrlForTranslate(with params: [String: String]) -> URL? {
        let parameters = params.map { "\($0)=\($1)" }.joined(separator: "&")
        guard let urlString = "\(baseURL)?key=\(token)&\(parameters)".addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed),
            let url = URL(string: urlString) else { return nil }
        return url
    }
    
     func makeUrlForImage (tags:String) -> URL?{
        
        var urlCompanents = URLComponents(string: baseUrlforImage )
        let clientId = URLQueryItem(name: "client_id", value: client_id)
        let tags = URLQueryItem(name: "query", value: tags)
        let count = URLQueryItem(name: "count", value: countImage)
        let orientation = URLQueryItem(name: "orientation", value: orientationImage)
        
        urlCompanents?.queryItems = [clientId,tags,count,orientation]
        
        return urlCompanents?.url! ?? nil
    }
}
