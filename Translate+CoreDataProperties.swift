//
//  Translate+CoreDataProperties.swift
//  Translator
//
//  Created by Алексей ]Чанов on 09/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//
//

import Foundation
import CoreData


extension Translate {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Translate> {
        return NSFetchRequest<Translate>(entityName: "Translate")
    }

    @NSManaged public var text: String?
    @NSManaged public var wordForTranslate: String?
    @NSManaged public var imagePath: String?

}
