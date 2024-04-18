//
//  CoreDataViewModel.swift
//  noissy


// A model for saving and fetching required data. Core Data is used.

import Foundation
import CoreData

class CoreDataViewModel: ObservableObject {
    var savedContents: [FeedEntity] = []
    var isInvited: Bool = false
    
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
        fetchInvited()
    }
    
    private func fetchInvited() {
        let request = NSFetchRequest<InvitedEntity>(entityName: "InvitedEntity")
        do {
            let results = try Self.persistentContainer.viewContext.fetch(request)
                // Check if there are any results
                if let invitedEntity = results.first {
                // Assuming your InvitedEntity has a boolean property named "isInvited"
                isInvited = invitedEntity.isInvited
            }
        } catch let error {
            print("There is an error with fetchInvited: \(error)")
        }
    }
    
    private func fetchContent() {
        let request = NSFetchRequest<FeedEntity>(entityName: "FeedEntity")
        do {
            savedContents = try context.fetch(request)
        } catch let error {
            print("There is an error with fetchContent: \(error)")
        }
    }
    
    
    func addContent(imageData: Data, contentData: Data, musicData: Data, channels: Int16, sampleRate: Double, duration: Double, sampleFrames: Int32, isLiked: Bool) {
        let newContent = FeedEntity(context: context)
        newContent.contenData = contentData
        newContent.previewImageData = imageData
        newContent.musicData = musicData
        newContent.channels = channels
        newContent.sampleRate = sampleRate
        newContent.duration = duration
        newContent.sampleFrames = sampleFrames
        newContent.isLiked = isLiked

        saveData()
    }
    
    func deleteContent(feed: FeedEntity) {
        context.delete(feed)
        saveData()
    }
    
    func likeToggle(feed:FeedEntity) {
        feed.isLiked.toggle()
        print(feed.isLiked)
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
    
    func invite() {
        let newContent = InvitedEntity(context: context)
        newContent.isInvited = true
        do {
            try context.save()
            fetchInvited()
        } catch let error{
            print(error.localizedDescription)
        }
    }
    
}
