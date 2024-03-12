//
//  SingleFeedView.swift


import SwiftUI
import AVKit

struct SingleFeedView: View {
    var contentData: Data?
    var feedID: Int?
    @ObservedObject var feedViewModel: FeedViewModel
    @State var mergedData: Data?
        
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        FeedContent(contentData: mergedData as NSData?, feedID: feedID, feedViewModel: feedViewModel)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(red: 0.2, green: 0.0, blue: 0.2))
            .ignoresSafeArea()
            .onAppear {
                feedViewModel.hideStatusBar = true
                if feedViewModel.newMerge {
                    if let musicDataStr = feedViewModel.musicDataString {
                        feedViewModel.currentTask = false
                        Task {
                            await mergeVideoAndAudio(videoData: feedViewModel.selectedMovie!, audioData: musicDataStr) { (data, error) in
                                if let data = data {
                                    mergedData = data
                                    feedViewModel.add(imageData: feedViewModel.imagePreviewData!, contentData: data)
                                }
                                if let error = error {
                                    print(error)
                                }
                            }
                        }
                        feedViewModel.newMerge = false
                    } else {
                        print("no music data")
                    }
                } else {
                    mergedData = contentData
                }
            }
            .onDisappear {
                feedViewModel.hideStatusBar = false
                if feedViewModel.selectedTab != 2 {
                    withAnimation {
                        feedViewModel.selectedTab = 2
                    }
                }
            }
    }
}


#Preview {
    SingleFeedView(feedViewModel: FeedViewModel())
}
