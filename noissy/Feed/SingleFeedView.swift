//
//  SingleFeedView.swift


import SwiftUI
import AVKit

struct SingleFeedView: View {
    var contentData: String? = nil
    var feedID: Int?
    var feedViewModel: FeedViewModel
    @State var mergedData: Data?
    
    var player: AVPlayer = AVPlayer()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        FeedContent(contentData: mergedData as NSData?, feedID: feedID, feedViewModel: feedViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.2, green: 0.0, blue: 0.2))
            .ignoresSafeArea()
            .onAppear {
                feedViewModel.hideStatusBar = true
                if let musicDataStr = feedViewModel.musicDataString {
                    Task {
                        await mergeVideoAndAudio(videoData: feedViewModel.selectedContent!, audioData: feedViewModel.musicDataString!) { (data, error) in
                            mergedData = data
                            print(error)
                        }
                    }
            
                } else {
                    print("no music data")
                }
            }
            .onDisappear {
                feedViewModel.hideStatusBar = false
            }
    }
}


#Preview {
    SingleFeedView(feedViewModel: FeedViewModel())
}
