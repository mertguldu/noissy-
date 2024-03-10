//
//  CoreDataViewModel.swift
//  noissy
//
//  Created by Mert Guldu on 2/25/24.
//

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    var savedContents: [FeedEntity] = []

    private static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CoreDataModel")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print(error)
            }
        }
        return container
    }()
    
    private var context: NSManagedObjectContext {
        return Self.persistentContainer.viewContext
    }

    
    init() {
        fetchContent()
    }
    
    private func fetchContent() {
        let request = NSFetchRequest<FeedEntity>(entityName: "FeedEntity")
        do {
            savedContents = try context.fetch(request)
        } catch let error {
            print("There is an error with fetchContent: \(error)")
        }
    }
    
    func addContent(imageData: Data, contentData: Data) {
        let newContent = FeedEntity(context: context)
        newContent.contenData = contentData
        newContent.previewImageData = imageData
        
        saveData()
    }
    
    func deleteContent(feed: FeedEntity) {
        context.delete(feed)
        saveData()
    }
    
    func reset() {
        for content in savedContents {
            context.delete(content)
        }
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
