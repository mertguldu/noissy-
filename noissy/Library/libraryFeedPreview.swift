//
//  libraryFeedPreview.swift
//  noissy


import SwiftUI

struct libraryFeedPreview: View {
    var imageData: NSData?
    var contentData: String?
    var feedID: Int?
    
    @ObservedObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationLink {
            SingleFeedView(contentData: contentData, feedID: feedID, feedViewModel: feedViewModel)
        } label: {
            PreviewView(imageData: imageData)
        }
    }
}

#Preview {
    libraryFeedPreview(feedViewModel: FeedViewModel())
}
