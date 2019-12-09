//
//  ImageUrl+CoreDataProperties.swift
//  Translator
//
//  Created by Алексей ]Чанов on 09/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//
//

import Foundation
import CoreData


extension ImageUrl {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageUrl> {
        return NSFetchRequest<ImageUrl>(entityName: "ImageUrl")
    }

    @NSManaged public var imagePath: String?
    @NSManaged public var translate: Translate?

}
