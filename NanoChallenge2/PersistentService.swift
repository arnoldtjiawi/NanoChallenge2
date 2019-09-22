//
//  PersistentService.swift
//  NanoChallenge2
//
//  Created by Arnold Tjiawi on 22/09/19.
//  Copyright © 2019 ArnoldTjiawi. All rights reserved.
//

import Foundation
import CoreData

class  PersistentService{
    // MARK: - Core Data stack
    private init(){}
    
    static var context: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    static  var persistentContainer: NSPersistentContainer = {
   
        let container = NSPersistentContainer(name: "NanoChallenge2")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    static func createReflection(title: String, date:Date, text:String) -> Reflection {
        let context = persistentContainer.viewContext
        let newReflection = NSEntityDescription.insertNewObject(forEntityName: "Reflection", into: context) as! Reflection
        
        newReflection.title = title
        newReflection.text = text
        newReflection.date = date
        
        do{
            try context.save()
            return newReflection
        } catch let err{
            print("Failed to save new Reflection", err)
            return newReflection
        }
    }
    
    static func fetchReflection() -> [Reflection]{
        let context = persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<Reflection>(entityName:"Reflection")
        
        do {
            let reflections = try context.fetch(fetchRequest)
            return reflections
        }catch let err{
            print("Failed to fetch reflection",err)
            return []
        }
    }
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
