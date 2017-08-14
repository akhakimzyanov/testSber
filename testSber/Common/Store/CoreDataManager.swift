//
//  CoreDataManager.swift
//  testSber
//
//  Created by Aidar on 13.08.17.
//  Copyright © 2017 Aidar Khakimzyanov. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager: NSObject {
    
    var applicationDocumentsDirectory: URL!
    var managedObjectModel: NSManagedObjectModel!
    var persistentStoreCoordinator: NSPersistentStoreCoordinator!
    var managedObjectContext: NSManagedObjectContext!
    
    
//MARK: - Init
    override init() {
        applicationDocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last
        
        let modelURL = Bundle(for: CoreDataManager.self).url(forResource: "testSber", withExtension: "momd")!
        managedObjectModel = NSManagedObjectModel(contentsOf: modelURL)!
        
        persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        let url = applicationDocumentsDirectory.appendingPathComponent("testSber.sqlite")
        let options = [NSMigratePersistentStoresAutomaticallyOption: NSNumber(value: true as Bool), NSInferMappingModelAutomaticallyOption: NSNumber(value: true as Bool)]
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject
            dict[NSLocalizedFailureReasonErrorKey] = "There was an error creating or loading the application's saved data." as AnyObject
            dict[NSUnderlyingErrorKey] = error as NSError
            
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            print("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        managedObjectContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
        super.init()
    }

    
//MARK: - Core Data Working
    func fetchVisitsWithPredicate(_ predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> [ManagedVisit]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Visit")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let queryResults = try managedObjectContext.fetch(fetchRequest)
            
            return queryResults as? [ManagedVisit]
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func fetchOrganizationsWithPredicate(_ predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) -> [ManagedOrganization]? {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Organization")
        fetchRequest.predicate = predicate
        fetchRequest.sortDescriptors = sortDescriptors
        
        do {
            let queryResults = try managedObjectContext.fetch(fetchRequest)

            return queryResults as? [ManagedOrganization]
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
        
        return nil
    }
    
    func saveOrganizations(organizations: [Organization]) {
        for organization in organizations {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Organization", into: managedObjectContext)
            
            entity.setValue(organization.organizationId, forKey: "organizationId")
            entity.setValue(organization.title, forKey: "title")
            entity.setValue(organization.latitude, forKey: "latitude")
            entity.setValue(organization.longitude, forKey: "longitude")
        }
        
        saveContext()
    }
    
     func saveVisits(visits: [Visit]) {
        for visit in visits {
            let entity = NSEntityDescription.insertNewObject(forEntityName: "Visit", into: managedObjectContext)
            
            entity.setValue(visit.title, forKey: "title")
            entity.setValue(visit.organizationId, forKey: "organizationId")
            
            if let id = visit.organizationId {
                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Organization")
                fetchRequest.predicate = NSPredicate(format: "organizationId like %@", id)
                
                if let organizations = fetchOrganizationsWithPredicate(NSPredicate(format: "organizationId like %@", id), sortDescriptors: []), organizations.count > 0 {
                    entity.setValue(organizations.first, forKey: "organization")
                }
            }
        }
        
        saveContext()
    }
    
    func saveContext() {
        do {
            try managedObjectContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
