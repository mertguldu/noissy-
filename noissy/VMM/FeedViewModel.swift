//
//  FeedViewModel.swift


import SwiftUI
import PhotosUI

class FeedViewModel: ObservableObject {
    @Published private var CoreModel = CoreDataViewModel()
    
    @Published var contentIsSelected: Bool = false
    @Published var selectedContent: UIImage? = nil
    @Published var isTaskCompleted: Bool = false
    @Published var scrollToLibrary: String = "home"
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            contentIsSelected = true
            isTaskCompleted = true
        }
    }
    
    var ContentLibrary: Array<FeedEntity> { // Stored contents
        return CoreModel.savedContents
    }
    
    func add(feedData: Data) { // add feed
        return CoreModel.addContent(contentData: feedData)
    }

    func reset() {
        print("reseting")
        return CoreModel.reset()
    }
}
