//
//  libraryView.swift

import SwiftUI

struct libraryView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: threeColumnGrid, spacing: 0) {
                    ForEach(feedViewModel.ContentLibrary.indices, id: \.self) { index in
                        libraryFeedPreview(index: index, feedViewModel: feedViewModel)
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
            GridItem(.flexible(minimum: 40), spacing: 0),
        ]
}



#Preview {
    libraryView(feedViewModel: FeedViewModel())
}




