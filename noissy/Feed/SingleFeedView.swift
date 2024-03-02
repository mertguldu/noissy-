//
//  SingleFeedView.swift


import SwiftUI
import AVKit

struct SingleFeedView: View {
    var contentData: NSData? = nil
    var feedID: Int?
    var feedViewModel: FeedViewModel

    var player: AVPlayer = AVPlayer()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        FeedContent(contentData: contentData, feedID: feedID, feedViewModel: feedViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.2, green: 0.0, blue: 0.2))
            .ignoresSafeArea()
            .onAppear {
                feedViewModel.hideStatusBar = true
            }
            .onDisappear {
                feedViewModel.hideStatusBar = false
            }
    }
}


#Preview {
    SingleFeedView(feedViewModel: FeedViewModel())
}
