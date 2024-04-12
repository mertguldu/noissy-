//
//  FeedViewModel.swift

// ViewModel of the app

import SwiftUI
import PhotosUI



struct SelectedMovie {
    let url: URL?
    let encodedData: String?
    let duration: Double?
}

class FeedViewModel: ObservableObject {
    @Published private var CoreModel = CoreDataViewModel()
    
    @Published var currentView: ShowView = .PARENT
    
    @Published var selectedTab: Int = 1
    @Published var hideStatusBar: Bool = false
    
    @Published var isTaskCompleted: Bool = false
    @Published var currentTask: Bool = false
    
    @Published var generatedMusic: APIResponse?
    //@Published var selectedMovie: String? = nil
    @Published var selectedMovie: SelectedMovie?
    @Published var musicDataString: String?
    @Published var mergedVideo: Data?
    @Published var imagePreviewData: Data?
    @Published var imageSequence: [UIImage] = []
    
    @Published var newMerge: Bool = false
    @Published var isErrorOccured = false
    @Published var errorMessage: String = ""
    
    @Published var invited: Bool = false
    
    let userID: String? = UIDevice.current.identifierForVendor?.uuidString
    
    init() {
        invited = CoreModel.isInvited
    }
    
    var ContentLibrary: Array<FeedEntity> { // Stored contents
        return CoreModel.savedContents
    }
    
    func add(imageData:Data, contentData: Data) { // add feed
        return CoreModel.addContent(imageData: imageData, contentData: contentData)
    }

    func delete(feed: FeedEntity) {
        return CoreModel.deleteContent(feed: feed)
    }
    
    func invite() {
        invited = true
        return CoreModel.invite()
    }
}
