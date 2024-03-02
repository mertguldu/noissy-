//
//  FeedViewModel.swift


import SwiftUI
import PhotosUI

class FeedViewModel: ObservableObject {
    @Published private var CoreModel = CoreDataViewModel()
    
    @Published var contentIsSelected: Bool = false
    @Published var selectedContent: NSData? = nil
    @Published var isTaskCompleted: Bool = false
    @Published var hideStatusBar: Bool = false
    @Published var selectedTab: Int = 1 //homePage
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            contentIsSelected = true
            isTaskCompleted = true
        }
    }
    
    var ContentLibrary: Array<FeedEntity> { // Stored contents
        return CoreModel.savedContents
    }
    
    func add(imageData:Data, contentData: Data) { // add feed
        return CoreModel.addContent(imageData: imageData, contenData: contentData)
    }

    func delete(feed: FeedEntity) {
        return CoreModel.deleteContent(feed: feed)
    }
}
