//
//  libraryFeedPreview.swift
//  noissy

// Each feed is stored here with a feed ID.

import SwiftUI

struct libraryFeedPreview: View {
    var videoURL: URL?
    var imageData: NSData?
    var contentData: Data?
    var feedID: Int?
    
    @ObservedObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationLink {
            if let videoURL = videoURL {
                SingleFeedView(videoURL: videoURL, feedID: feedID, feedViewModel: feedViewModel)
            }
        } label: {
            PreviewView(imageData: imageData)
        }
    }
}

#Preview {
    libraryFeedPreview(feedViewModel: FeedViewModel())
}
