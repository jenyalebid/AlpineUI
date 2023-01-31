//
//  NSManagedObject.swift
//  AlpineUI
//
//  Created by Jenya Lebid on 1/4/23.
//

import CoreData

public extension NSManagedObject {
    
    static var entityName: String {
        String(describing: Self.self)
    }
    
    static func findObjects(by predicate: NSPredicate, in context: NSManagedObjectContext) -> [NSManagedObject] {
        let request = NSFetchRequest<NSManagedObject>(entityName: Self.entityName)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        var result: [NSManagedObject] = []
        context.performAndWait {
            do {
                result = try context.fetch(request)
            } catch {
                print(error)
            }
        }
        return result
    }
    
    static func findObject(by predicate: NSPredicate, in context: NSManagedObjectContext) -> NSManagedObject? {
        let request = NSFetchRequest<NSManagedObject>(entityName: Self.entityName)
        request.predicate = predicate
        request.returnsObjectsAsFaults = false
        request.fetchLimit = 1
        var result: NSManagedObject?
        context.performAndWait {
            do {
                result = try context.fetch(request).first
            } catch {
                print(error)
            }
        }
        return result
    }
    
    func saveMergeInTo(context: NSManagedObjectContext) {
        guard let selfContext = self.managedObjectContext else {
            assertionFailure()
            return
        }
        do {
            try selfContext.performAndWait {
                try selfContext.save()
                try context.performAndWait {
                    try context.save()
                }
            }
        }
        catch {
            print(error.localizedDescription)
        }
    }
}
