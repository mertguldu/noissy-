//
//  noissy.swift

import SwiftUI

struct noissy: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        NavigationStack {
                ZStack {
                    noissyHeader(feedViewModel: feedViewModel)
                    CombinedView(feedViewModel: feedViewModel)
                        .padding(.top, 70)
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(mainColor)
            
                .navigationDestination(isPresented: $feedViewModel.isTaskCompleted) {
                    if let content = feedViewModel.selectedContent{
                        SingleFeedView(feedViewModel: feedViewModel, contentData: content)
                    }
                }
            }
            .tint(.white)
            .edgesIgnoringSafeArea(.all)
            .statusBarHidden(feedViewModel.hideStatusBar)
            .onAppear {
                UIScrollView.appearance().bounces = false
            }
    }
}


#Preview {
    noissy(feedViewModel: FeedViewModel())
       
}
