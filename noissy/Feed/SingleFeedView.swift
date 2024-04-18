//
//  SingleFeedView.swift

// Feed View. A view that shows the individual generated music with the corresponding video. 

import SwiftUI
import AVKit

struct SingleFeedView: View {
    var videoURL: URL
    var audioURL: URL?
    var videoVolume: Float?
    var audioVolume: Float?
    var feedID: Int?
    var feedViewModel: FeedViewModel
    
    @State var mergedURL: URL?
    @State private var mergedData: Data?
    
    var body: some View {
        ZStack {
            if let mergedURL = mergedURL {
                FeedContent(videoURL: mergedURL, feedID: feedID, feedViewModel: feedViewModel)
                    .zIndex(0)
                if (audioURL != nil) {
                    //PrevPageButton(feedViewModel: feedViewModel, currentView: .EDITING)
                    NextPageButton(feedViewModel: feedViewModel, currentView: .PARENT)
                }
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
                    DispatchQueue.global(qos: .background).async {
                        Task {
                            await mergeVideoAudio(videoURL: videoURL, audioURL: audioURL, videoVolume: videoVolume!, audioVolume: audioVolume!) { (data, error) in
                                
                                if let data = data {
                                    mergedData = data
                                    mergedURL = dataToURL(data: data as NSData)
                                }
                                
                                if let error = error {
                                    print(error)
                                }
                            }
                        }
                    }

                    feedViewModel.newMerge = false
                } else {
                    mergedURL = videoURL
                }
        }
        .onDisappear {
            if audioURL != nil {
                if let mergedData = mergedData {
                    if let imagePreviewData = feedViewModel.imagePreviewData {
                        print("feed is liked:", feedViewModel.isLiked)
                        if let encodedString = feedViewModel.generatedMusic?.encodedData {
                            let generatedData = Data(base64Encoded: encodedString)
                            let channels = feedViewModel.generatedMusic?.channels
                            let sampleRate = feedViewModel.generatedMusic?.sampleRateHz
                            let duration = feedViewModel.generatedMusic?.duration
                            let sampleFrames = feedViewModel.generatedMusic?.sampleFrames
                            
                            feedViewModel.add(imageData: imagePreviewData, contentData: mergedData, musicData: generatedData!, channels: channels!, sampleRate: sampleRate ?? 0, duration: duration!, sampleFrames: sampleFrames!, isLiked: feedViewModel.isLiked)
                        }
                    }
                }
            }
            
            feedViewModel.hideStatusBar = false
            
            feedViewModel.selectedMovie = nil
            feedViewModel.imagePreviewData = nil
            feedViewModel.generatedMusic = nil
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
    SingleFeedView(videoURL: exampleVideoURL, audioURL: exampleAudioURL, videoVolume: 1, audioVolume: 1, feedViewModel: FeedViewModel())
}
