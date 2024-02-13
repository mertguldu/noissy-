//
//  feedView.swift


//Since no image is saved at t=0, this page will be empty. To see the page add dummy feed by changing
//singleFeedView(feed: feedViewModel.ContentLibrary[index]). Or run the app, save an image and check the
//feedView by goinf to the library and selecting a feed.

import SwiftUI

struct feedView: View {
    @State var scrollTo: Int
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollViewReader{ scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0){
                    ForEach(feedViewModel.ContentLibrary.indices, id: \.self){ index in
                        singleFeedView(feed: feedViewModel.ContentLibrary[index]) //place every feed vertically
                            .id(index) //id each feed to differentiate
                    }.onAppear(perform: {
                        scrollView.scrollTo(scrollTo) //scroll to the selected feed
                    })
                }
            }.scrollTargetBehavior(.paging) //make the scrolling discrete, not continuos - like paging
                .edgesIgnoringSafeArea(.all) //fill the entire screen
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.1, green: 0.0, blue: 0.1))
        }
    }
}

#Preview {
    feedView(scrollTo: 0, feedViewModel: FeedViewModel())
}
