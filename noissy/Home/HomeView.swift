//
//  HomeView.swift


import SwiftUI

struct HomeView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack(alignment:.center){
            VStack(spacing:0){
                HeaderLabel(feedViewModel: feedViewModel)
                Spacer()
                OpenMedia(feedViewModel: feedViewModel)
                Spacer()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    HomeView(feedViewModel: FeedViewModel())
        .background(.black)
        
}
