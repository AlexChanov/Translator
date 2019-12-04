//
//  NetworkServices.swift
//  Translator
//
//  Created by Алексей ]Чанов on 03/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import Foundation

final class TranslateNetworkService {
    
    let apiWrapper = APIWrapper()
    /// Perform request with completion
    ///
    /// - Parameters:
    ///   - params: API keys + translate data
    ///   - completion: request response
    private func makeRequest(with params: [String: String], completion: @escaping (Data?, ServiceError?) -> Void) {
        
        guard let url = apiWrapper.makeUrlForTranslate(with: params) else {
            completion(nil, .wrongUrl)
            return
        }
        
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(nil, .remoteServer)
                return
            }
            completion(data,nil)
        }
        task.resume()
    }
    
    /// Prepare url for request
    ///
    /// - Parameter params: API keys + translate data
    /// - Returns: url
   
    

    
    
    func translate(_ text: String, lang: String, completion: @escaping (TranslationResult?, ServiceError?) -> Void) {
        let params = ["text": text, "lang": lang]
        makeRequest(with: params) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let response = try? JSONDecoder().decode(TranslationResult.self, from: data)
            completion(response, error)
        }
    }
    
}
