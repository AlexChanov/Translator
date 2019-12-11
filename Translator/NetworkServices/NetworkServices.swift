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
    let group = DispatchGroup()
    let config = URLSessionConfiguration.default
    lazy var session = URLSession(configuration: config)
    
    
    /// Perform request with completion
    ///
    /// - Parameters:
    ///   - params: API keys + translate data
    ///   - completion: request response
    private func makeRequestTranslate(with params: [String: String], completion: @escaping (Data?, ServiceError?) -> Void) {
        
        guard let url = apiWrapper.makeUrlForTranslate(with: params) else {
            completion(nil, .wrongUrl)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(nil, .remoteServer)
                return
            }
            completion(data,nil)
        }
        task.resume()
    }
    
    private func makeRequestImage(with tags: String, completion: @escaping (Data?, ServiceError?) -> Void) {
        
        guard let url = apiWrapper.makeUrlForImage(tags: tags) else {
            completion(nil, .wrongUrl)
            return
        }
        
        let task = session.dataTask(with: url) { (data, response, error) in
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                completion(nil, .remoteServer)
                return
            }
            completion(data,nil)
        }
        task.resume()
    }
    
    func translate(_ text: String, lang: String, completion: @escaping (FinalResult?, ServiceError?) -> Void) {
        let params = ["text": text, "lang": lang]
        
        var resultTranlate: TranslationResult?
        var resultImage = [Image]()

        group.enter()
            self.makeRequestTranslate(with: params) { (data, error) in
            guard let data = data else {
                completion(nil, error)
                return
            }
            let response = try? JSONDecoder().decode(TranslationResult.self, from: data)
            if response != nil {
                resultTranlate = response
                self.group.leave()
            }
        }
        
        
      group.wait()
        guard let tag = resultTranlate?.text.first  else{ return }
        self.makeRequestImage(with: tag, completion: { (data, error) in
        
            guard let data = data else {
                    completion(nil, error)
                    return
                }
            do {
                let image = try JSONDecoder().decode([Image].self, from: data)
                
                resultImage = image
                
                let result = FinalResult(translate: resultTranlate!, image: resultImage)

                completion(result, error)
            }catch{
                print("Error serialization json, ", error)
                completion(nil, error as? ServiceError)
            }
            })
    }
    
}
