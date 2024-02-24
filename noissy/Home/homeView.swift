//
//  homeView.swift


import SwiftUI

struct homeView: View {
    @ObservedObject var feedViewModel: FeedViewModel

    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                Text("Click to upload your video")
                    .foregroundStyle(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.top)
                Spacer()

               
                openMedia(feedViewModel: feedViewModel)
                    .navigationDestination(isPresented: $feedViewModel.isTaskCompleted) {
                        if let uiImage = feedViewModel.selectedContent {
                            let feed = Feed(content: uiImage)
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
