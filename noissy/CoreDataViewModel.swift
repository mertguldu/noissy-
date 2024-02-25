//
//  CoreDataViewModel.swift
//  noissy
//
//  Created by Mert Guldu on 2/25/24.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }

    @Published var savedContents: [FeedEntity] = []
    
    init() {
        fetchContent()
    }
    
    func fetchContent() {
        let request = NSFetchRequest<FeedEntity>(entityName: "FeedEntity")
        do {
            savedContents = try context.fetch(request)
        } catch let error {
            print("There is an error with fetchContent: \(error)")
        }
    }
    
    func addContent(contentData: Data) {
        let newContent = FeedEntity(context: context)
        newContent.content = contentData
        saveData()
    }
    
    
    func saveData() {
        do {
            try context.save()
            fetchContent()
        } catch let error {
            print("There is an error with saveData: \(error)")
        }
    }
}
