//
//  homeView.swift


import SwiftUI

struct homeView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                HeaderLabel()
                Spacer()
                openMedia(feedViewModel: feedViewModel)
                    .navigationDestination(isPresented: $feedViewModel.isTaskCompleted) {
                        if let content = feedViewModel.selectedContent{
                            let feed = Feed(content: content)
                            singleFeedView(feed: feed, feedViewModel: feedViewModel)
                                .toolbar(.hidden)
                        }
                    }
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}



#Preview {
    homeView(feedViewModel: FeedViewModel())
        .background(.black)
        
}
