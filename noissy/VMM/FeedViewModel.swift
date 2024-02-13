//
//  FeedViewModel.swift


import SwiftUI
import PhotosUI

@MainActor //LOOK into this. When removed, there is a warning for update
class FeedViewModel: ObservableObject {
    /*Acts as a bridge between the view and the logic.*/
    
    @Published private var Model = feedModel<UIImage>(contentLibrary: [])
    
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task{
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    let feed = feedModel.Feed(content: uiImage)
                    add(feed: feed)
                }
            }
        }
    }
    
    var ContentLibrary: Array<feedModel<UIImage>.Feed> { // Stored contents
        return Model.contentLibrary
    }
    
    func add(feed: feedModel<UIImage>.Feed) { // add feed
        return Model.add(feed: feed)
    }

    
}
