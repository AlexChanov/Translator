//
//  Storage.swift
//  Translator
//
//  Created by Алексей ]Чанов on 09/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import CoreData


class Stroage {
    
    static func saveImage(_ url : String) -> ImageUrl {
  
        let context = CoreDataStack.sharedInstance.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ImageUrl", in: context)
        let imageUrlEntity = NSManagedObject(entity: entity!, insertInto: context) as! ImageUrl
//        imageUrlEntity
        return imageUrlEntity
    }
        
}
