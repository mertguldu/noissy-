//
//  feedView.swift

import SwiftUI

struct feedView: View {
    @State var scrollTo: Int? = nil
    var feedViewModel: FeedViewModel = FeedViewModel()
    
    var body: some View {
        ScrollViewReader{ scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0) {
                    ForEach(feedViewModel.ContentLibrary.indices, id: \.self){ index in
                        singleFeedView(feed: feedViewModel.ContentLibrary[index], feedViewModel: feedViewModel)
                            .id(index)
                    }.onAppear(perform: {
                        if let position = scrollTo {
                            scrollView.scrollTo(position)
                        }
                    })
                }
            }.scrollTargetBehavior(.paging)
            .edgesIgnoringSafeArea(.all)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.1, green: 0.0, blue: 0.1))
        }
    }
}

#Preview {
    feedView()
}
