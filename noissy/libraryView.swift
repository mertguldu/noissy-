//
//  libraryView.swift

//check feedView page explanation to see the UI of this page.

import SwiftUI

struct libraryView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    private let threeColumnGrid = [ //Number of columns and their features. Used in LazyVGrid.
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
        ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: threeColumnGrid, spacing: 0) {
                ForEach(feedViewModel.ContentLibrary.indices, id: \.self) { index in //place every feed inside the library view with the determined features.
                    CustomNavigationLink(title: "") { //check CustomNavigationLink file for info
                        feedView(scrollTo: index, feedViewModel: feedViewModel) // navigate to the matching feed when it is cliceked
                    } label: {
                        
                        Image(uiImage: feedViewModel.ContentLibrary[index].content) //place every feed
                            .resizable()
                            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                    }
                }
            }
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



#Preview {
    libraryView(feedViewModel: FeedViewModel())
}




