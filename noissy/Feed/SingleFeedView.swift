//
//  SingleFeedView.swift

// Feed View. A view that shows the individual generated music with the corresponding video. 

import SwiftUI
import AVKit

struct SingleFeedView: View {
    var videoURL: URL
    var audioURL: URL?
    var feedID: Int?
    var feedViewModel: FeedViewModel
    
    @State var mergedURL: URL?
    
    
    
    var body: some View {
        ZStack {
            //let cacheURL = dataToURL(data: mergedData! as NSData)
            if let mergedURL = mergedURL {
                FeedContent(videoURL: mergedURL, feedID: feedID, feedViewModel: feedViewModel)
                    .zIndex(0)
                NextPageButton(feedViewModel: feedViewModel, currentView: .PARENT)
                

            } else {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.2, green: 0.0, blue: 0.2))
            
        .onAppear {
            feedViewModel.hideStatusBar = true
                
                if let audioURL = audioURL {
                    feedViewModel.currentTask = false
                    Task {
                        await mergeVideoAudio(videoURL: videoURL, audioURL: audioURL) { (data, error) in
                            if let data = data {
                                mergedURL = dataToURL(data: data as NSData)
                                //feedViewModel.add(imageData: (feedViewModel.imagePreviewData)!, contentData: data)
                            }
                            if let error = error {
                                print(error)
                            }
                        }
                    }
                    feedViewModel.newMerge = false
                } else {
                    mergedURL = videoURL
                }
        }
        .onDisappear {
            feedViewModel.hideStatusBar = false
            
            feedViewModel.selectedMovie = nil
            feedViewModel.imagePreviewData = nil
            feedViewModel.musicDataString = nil
            feedViewModel.mergedVideo = nil
            mergedURL = nil
                
            if feedViewModel.selectedTab != 2 {
                withAnimation {
                    feedViewModel.selectedTab = 2
                }
            }
        }
    }
}


#Preview {
    SingleFeedView(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")!, audioURL: Bundle.main.url(forResource: "sample2", withExtension: "m4a")!, feedViewModel: FeedViewModel())
}
