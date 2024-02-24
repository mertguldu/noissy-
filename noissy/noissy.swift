//
//  noissy.swift

import SwiftUI

struct noissy: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        if !feedViewModel.contentIsSelected {
            NavigationView{
                ZStack {
                    noissyHeader()
                    containerView(feedViewModel: feedViewModel)
                        .padding(.top, 70)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(mainColor)
            }
            .edgesIgnoringSafeArea(.all)
        } else {
            if let uiImage = feedViewModel.selectedContent {
                let selected_Feed = Feed(content: uiImage)
                singleFeedView(feed: selected_Feed, feedViewModel: feedViewModel)
            }
        }
    }
}


#Preview {
    noissy(feedViewModel: FeedViewModel())
       
}
