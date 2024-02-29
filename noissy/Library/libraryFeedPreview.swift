//
//  libraryFeedPreview.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct libraryFeedPreview: View {
    @ObservedObject var feedViewModel: FeedViewModel
    var contentData: NSData?

    var body: some View {
        NavigationLink {
            SingleFeedView(feedViewModel: feedViewModel, contentData: contentData)
        } label: {
            PreviewView(videoData: contentData)
        }
    }
}

#Preview {
    libraryFeedPreview(feedViewModel: FeedViewModel(), contentData: nil)
}
