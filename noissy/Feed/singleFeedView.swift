//
//  singleFeedView.swift


import SwiftUI

struct singleFeedView: View {
    var feedViewModel: FeedViewModel
    var contentData: NSData? = nil
    
    var body: some View {
        NavigationView {
            feedContent(contentData: contentData)
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
            
        
    }
}


#Preview {
    singleFeedView(feedViewModel: FeedViewModel())
}
