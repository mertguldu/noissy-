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
