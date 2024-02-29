//
//  FeedView.swift

import SwiftUI

struct FeedView: View {
    @State var scrollTo: Int? = nil
    var feedViewModel: FeedViewModel
    
    var body: some View {
        ScrollViewReader{ scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0) {
                    ForEach(feedViewModel.ContentLibrary.indices, id: \.self){ index in
                        if let contentData = feedViewModel.ContentLibrary[index].contenData {
                            SingleFeedView(feedViewModel: feedViewModel, contentData: contentData as NSData)
                        }
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
    FeedView(feedViewModel: FeedViewModel())
}
