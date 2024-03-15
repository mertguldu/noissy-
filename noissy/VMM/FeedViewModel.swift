//
//  FeedViewModel.swift


import SwiftUI
import PhotosUI

class FeedViewModel: ObservableObject {
    @Published private var CoreModel = CoreDataViewModel()
    
    @Published var selectedTab: Int = 1
    @Published var hideStatusBar: Bool = false
    
    @Published var isTaskCompleted: Bool = false
    @Published var currentTask: Bool = false
    
    @Published var selectedMovie: String? = nil
    @Published var musicDataString: String?
    @Published var mergedVideo: Data?
    @Published var imagePreviewData: Data?
    
    @Published var newMerge: Bool = false
    @Published var isErrorOccured = false
    @Published var errorMessage: String = ""
    
    var ContentLibrary: Array<FeedEntity> { // Stored contents
        return CoreModel.savedContents
    }
    
    func add(imageData:Data, contentData: Data) { // add feed
        return CoreModel.addContent(imageData: imageData, contentData: contentData)
    }

    func delete(feed: FeedEntity) {
        return CoreModel.deleteContent(feed: feed)
    }
}
