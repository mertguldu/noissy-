//
//  homeView.swift


import SwiftUI

struct homeView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @ObservedObject var CoreDataVM: CoreDataViewModel = CoreDataViewModel()
    
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
                        if let lastUpdatedEntity = CoreDataVM.savedContents.last {
                            let lastFeed = Feed(content: UIImage(data: lastUpdatedEntity.content!)!)
                            singleFeedView(feed: lastFeed, feedViewModel: feedViewModel)
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
