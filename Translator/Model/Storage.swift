//
//  Storage.swift
//  Translator
//
//  Created by Алексей ]Чанов on 09/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import CoreData


final class Storage {
    
    // MARK: - Func for save in CoreData
    static func saveImage(_ url : String) -> ImageUrl {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ImageUrl", in: context)
        let imageUrlEntity = NSManagedObject(entity: entity!, insertInto: context) as! ImageUrl
        imageUrlEntity.imagePath = url
        return imageUrlEntity
    }
    
    static func saveTranslateInfo(wordForTranslate : String, translatedWord: String) -> Translate? {
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Translate", in: context)
        let translateEntity = NSManagedObject(entity: entity!, insertInto: context) as! Translate
        translateEntity.text = translatedWord
        translateEntity.wordForTranslate = wordForTranslate
        
        do {
            try context.save()
            print("Save! Good Job!")
            return translateEntity
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
        
}
