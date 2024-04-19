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
    @Published var regenarating: Bool = false
    @Published var isLiked: Bool = false
    @Published var showFavouriteMenu: Bool = false
    
    @Published var generatedMusic: APIResponse?
    @Published var selectedMovie: SelectedMovie?
    @Published var mergedVideo: Data?
    @Published var imagePreviewData: Data?
    @Published var imageSequence: [UIImage] = []
    @Published var currentAudioURL: URL?
    
    @Published var videoVolume: Float?
    @Published var audioVolume: Float?
    
    @Published var newMerge: Bool = false
    @Published var isErrorOccured = false
    @Published var errorMessage: String = ""
    
    @Published var ActiveFavoritePlayer: Int = -1
    @Published var selectedFavoritePlayer: Int = -1
    @Published var selectedFavouriteAudioURL: URL?
    
    @Published var invited: Bool = false
    
    let userID: String? = UIDevice.current.identifierForVendor?.uuidString
    
    init() {
        invited = CoreModel.isInvited
    }
    
    var ContentLibrary: Array<FeedEntity> { // Stored contents
        return CoreModel.savedContents
    }
    
    func add(imageData:Data, contentData: Data, musicData: Data, channels: Int16, sampleRate: Double, duration: Double, sampleFrames: Int32, isLiked: Bool) { // add feed
        return CoreModel.addContent(imageData: imageData, contentData: contentData, musicData: musicData, channels: channels, sampleRate: sampleRate, duration: duration, sampleFrames: sampleFrames, isLiked: isLiked)
    }
    
    func likeToggle(feed: FeedEntity) {
        return CoreModel.likeToggle(feed: feed)
    }

    func delete(feed: FeedEntity) {
        return CoreModel.deleteContent(feed: feed)
    }
    
    func invite() {
        invited = true
        return CoreModel.invite()
    }
}
