//
//  LibraryView.swift

import SwiftUI

struct LibraryView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LazyVGrid(columns: threeColumnGrid, spacing: 20) {
                    ForEach(feedViewModel.ContentLibrary.indices, id: \.self) { index in
                        let contentData = feedViewModel.ContentLibrary[index].contenData
                        libraryFeedPreview(feedViewModel: feedViewModel, contentData: contentData as NSData?)
                    }
                }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .ignoresSafeArea()
    }
    
    private let threeColumnGrid = [ //Number of columns and their features.
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
        ]
}

#Preview {
    LibraryView(feedViewModel: FeedViewModel())
}




