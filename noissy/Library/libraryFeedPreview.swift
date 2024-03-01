//
//  libraryFeedPreview.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct libraryFeedPreview: View {
    var imageData: NSData?
    var contentData: NSData?

    @ObservedObject var feedViewModel: FeedViewModel

    var body: some View {
        NavigationLink {
            SingleFeedView(feedViewModel: feedViewModel, contentData: contentData)
        } label: {
            PreviewView(imageData: imageData)
        }
    }
}

#Preview {
    libraryFeedPreview(feedViewModel: FeedViewModel())
}
