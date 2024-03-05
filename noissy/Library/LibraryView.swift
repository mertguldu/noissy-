//
//  LibraryView.swift

import SwiftUI

struct LibraryView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 0) {
                LazyVGrid(columns: threeColumnGrid, spacing: 25) {
                    ForEach(feedViewModel.ContentLibrary.indices, id: \.self) { index in
                        let imageData = feedViewModel.ContentLibrary[index].previewImageData
                        let videoData = feedViewModel.ContentLibrary[index].contenData
                        
                        libraryFeedPreview(imageData: imageData as NSData?, contentData: "", feedID: index, feedViewModel: feedViewModel)
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




