//
//  EntryController.swift
//  Journal+NSFRC27
//
//  Created by Darin Marcus Armstrong on 6/20/19.
//  Copyright © 2019 Karl Pfister. All rights reserved.
//

import Foundation
import CoreData

class EntryController{
    
    static let sharedInstance = EntryController()
    
    var fetchedResultsController: NSFetchedResultsController<Entry>
    
    init() {
        
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: false)]
        
        let resultsController: NSFetchedResultsController<Entry> = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: CoreDataStack.context, sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedResultsController = resultsController
        do {
            try fetchedResultsController.performFetch()
        } catch {
            print("There was an error performing the fetch: \(error.localizedDescription)")
        }
    }
    
    
    //create
    func createEntry(withTitle title: String, body: String) {
        
        //save
        let entry = Entry(title: title, body: body)
        saveToPersistentStore()
    }
    
    func updateEntry(withEntry entry: Entry, newTitle: String, newBody: String) {
        entry.title = newTitle
        entry.body = newBody
        
        saveToPersistentStore()
    }
    
    func delete(entry: Entry) {
        //        entry.managedObjectContext?.delete(entry)
        CoreDataStack.context.delete(entry)
        saveToPersistentStore()
    }
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch {
            print("Error saving to persistent storage: \(error.localizedDescription)")
        }
    }
}
