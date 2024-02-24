//
//  FeedViewModel.swift


import SwiftUI
import PhotosUI

class FeedViewModel: ObservableObject {
    @Published private var Model = feedModel<UIImage>(contentLibrary: [])
    @Published var contentIsSelected: Bool = false
    @Published var selectedContent: UIImage? = nil
    
    var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
            withAnimation(.easeIn) {
                contentIsSelected = true
            }
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        
        Task{
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedContent = uiImage
                    let feed = Feed(content: uiImage)
                    add(feed: feed)
                }
            }
        }
    }
    
    var ContentLibrary: Array<Feed<UIImage>> { // Stored contents
        return Model.contentLibrary
    }
    
    func add(feed: Feed<UIImage>) { // add feed
        return Model.add(feed: feed)
    }

    
}
