//
//  libraryFeedPreview.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct libraryFeedPreview: View {
    var index: Int?
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        CustomNavigationLink(title: "") {
            if let i = index {
                if feedViewModel.ContentLibrary.isEmpty == false {
                    SingleFeedView(feedViewModel: feedViewModel, contentData: feedViewModel.ContentLibrary[i].contenData as NSData?)
                }
            }
        } label: {
            if let i = index {
                if let contentData = feedViewModel.ContentLibrary[i].contenData {
                    PreviewView(videoData: contentData as NSData)
                }
            }
        }
    }
}


#Preview {
    libraryFeedPreview(index: 0, feedViewModel: FeedViewModel())
}
