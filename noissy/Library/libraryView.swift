//
//  libraryView.swift

import SwiftUI

struct libraryView: View {
    var feedViewModel: FeedViewModel
    @ObservedObject var CoreDataVM: CoreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: threeColumnGrid, spacing: 0) {
                    ForEach(CoreDataVM.savedContents.indices, id: \.self) { index in
                        libraryFeedPreview(index: index, feedViewModel: feedViewModel, CoreDataVM: CoreDataVM)
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




