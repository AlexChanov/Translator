//
//  CoreDataStack.swift
//  Translator
//
//  Created by Алексей ]Чанов on 09/12/2019.
//  Copyright © 2019 Алексей Чанов. All rights reserved.
//

import UIKit
import CoreData

class CoreDataStack: NSObject {
    
    static let sharedInstance = CoreDataStack()
    private override init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
