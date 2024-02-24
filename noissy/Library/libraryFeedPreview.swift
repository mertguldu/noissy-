//
//  libraryFeedPreview.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct libraryFeedPreview: View {
    var index: Int?
    var feedViewModel: FeedViewModel = FeedViewModel()

    var body: some View {
        CustomNavigationLink(title: "") {
            feedView(scrollTo: index, feedViewModel: feedViewModel)
        } label: {
            if let i = index {
                Image(uiImage: feedViewModel.ContentLibrary[i].content)
                    .resizable()
                    .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
            }
        }
    }
}

#Preview {
    libraryFeedPreview()
}
