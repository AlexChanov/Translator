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

    @NSManaged public var imagePath: String?
    @NSManaged public var text: String?
    @NSManaged public var wordForTranslate: String?
    @NSManaged public var imageUrl: NSSet?

}

// MARK: Generated accessors for imageUrl
extension Translate {

    @objc(addImageUrlObject:)
    @NSManaged public func addToImageUrl(_ value: ImageUrl)

    @objc(removeImageUrlObject:)
    @NSManaged public func removeFromImageUrl(_ value: ImageUrl)

    @objc(addImageUrl:)
    @NSManaged public func addToImageUrl(_ values: NSSet)

    @objc(removeImageUrl:)
    @NSManaged public func removeFromImageUrl(_ values: NSSet)

}
