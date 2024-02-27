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
            feedView(scrollTo: index, feedViewModel: feedViewModel)
        } label: {
            if let i = index {
                if let contentData = feedViewModel.ContentLibrary[i].content {
                    if let uiimage = UIImage(data: contentData) {
                        previewContent(uiImage: uiimage)
                    }
                }
            }
        }
    }
}


#Preview {
    libraryFeedPreview(index: 0, feedViewModel: FeedViewModel())
}
