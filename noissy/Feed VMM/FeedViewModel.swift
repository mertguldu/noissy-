//
//  FeedViewModel.swift


import SwiftUI
import PhotosUI

@MainActor
class FeedViewModel: ObservableObject {
    @Published private var Model = feedModel<UIImage>(contentLibrary: [])
    @Published private var CoreModel = CoreDataViewModel()
    
    @Published var contentIsSelected: Bool = false
    @Published var selectedContent: UIImage? = nil
    @Published var isTaskCompleted: Bool = false
    
    @Published var imageSelection: PhotosPickerItem? = nil {
        didSet {
            setImage(from: imageSelection)
            contentIsSelected = true
            isTaskCompleted = true
        }
    }
    
    private func setImage(from selection: PhotosPickerItem?) {
        guard let selection else { return }
        Task{
            if let data = try? await selection.loadTransferable(type: Data.self) {
                if let uiImage = UIImage(data: data) {
                    selectedContent = uiImage
                    CoreModel.addContent(contentData: data)
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
