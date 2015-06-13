//
//  CoreDataStack.swift
//  DogWalk
//
//  Created by Macbook Pro MD102 on 6/12/15.
//  Copyright (c) 2015 Loki. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    var context:NSManagedObjectContext
    var psc:NSPersistentStoreCoordinator
    var model:NSManagedObjectModel
    var store:NSPersistentStore?
    
    init() {
        //1
        let bundle = NSBundle.mainBundle()
        let modeURL = bundle.URLForResource("DogWalk", withExtension: "momd")
        model = NSManagedObjectModel(contentsOfURL: modeURL!)!
        
        //2
        psc = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        //3
        context = NSManagedObjectContext()
        context.persistentStoreCoordinator = psc
        
        //4
        let documentsUrl = applicationDocumentDirectory()
        let storeUrl = documentsUrl.URLByAppendingPathComponent("DogWalk")
        
        let options = [NSMigratePersistentStoresAutomaticallyOption:true]
        var error:NSError? = nil
        
        store = psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: storeUrl, options: options, error: &error)
        
        if store == nil {
            println("Error adding persistent store: \(error)")
            abort()
        }
        
    }
    
    func applicationDocumentDirectory() -> NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask) as! Array<NSURL>
        
        return urls[0]
    }
    func saveContext() {
        var error:NSError?
        if context.hasChanges && !context.save(&error){
            println("Could not save: \(error),\(error?.userInfo)")
        }
    }
    
}

