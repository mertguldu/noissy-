//
//  singleFeedView.swift


import SwiftUI

struct singleFeedView: View {
    var feed: Feed<UIImage>? = nil
    var feedViewModel: FeedViewModel
    
    var body: some View {
        if let currentFeed = feed {
            NavigationView {
                feedContent(content: currentFeed.content)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color(red: 0.2, green: 0.0, blue: 0.2))
                    .ignoresSafeArea()
                
                    .navigationBarHidden(!feedViewModel.contentIsSelected)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarItems(leading: backButton(action: {
                        withAnimation(.easeOut) {
                            feedViewModel.contentIsSelected = false
                            feedViewModel.isTaskCompleted = false
                            feedViewModel.scrollToLibrary = "library"
                        }
                    }))
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .ignoresSafeArea()
            
        } else {
            Text("No Feed to Show")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.2, green: 0.0, blue: 0.2))
        }
    }
}


#Preview {
    singleFeedView(feedViewModel: FeedViewModel())
}
