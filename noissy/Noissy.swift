//
//  Noissy.swift
//  noissy
//
//  Created by Mert Guldu on 4/12/24.
//

import SwiftUI

struct Noissy: View {
    
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        VStack {
            switch feedViewModel.currentView {
            case .PARENT:
                noissyMain(feedViewModel: feedViewModel)
                
            case .EDITING:
                NavigationStack {
                    if let selectedMovie = feedViewModel.selectedMovie {
                        if let generatedMusic = feedViewModel.generatedMusic {
                            let audioData = Data(base64Encoded: generatedMusic.encodedData!)
                            let audioURL = dataToURL2(data: audioData! as NSData, url: "audioGen.wav")
                            EditView(feedViewModel: feedViewModel, videoURL: selectedMovie.url!, audioURL: audioURL, duration: selectedMovie.duration ?? 0.0)
                                .toolbar(.hidden)
                        }
                    }
                }
                .transition(feedViewModel.regenarating ? .regenarate : .backslide)
                
            case .PREVIEW:
                NavigationStack {
                    if let selectedMovie = feedViewModel.selectedMovie {
                        if let generatedMusic = feedViewModel.generatedMusic {
                            let audioData = Data(base64Encoded: generatedMusic.encodedData!)
                            let audioURL = dataToURL2(data: audioData! as NSData, url: "audioGen.wav")
                            SingleFeedView(videoURL: selectedMovie.url!, audioURL: audioURL, videoVolume: feedViewModel.videoVolume, audioVolume: feedViewModel.audioVolume, feedViewModel: feedViewModel)
                                .toolbar(.hidden)
                        }
                    }
                }
                .transition(.bottomslide)
                
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(mainColor)
    }
}

#Preview {
    Noissy(feedViewModel: FeedViewModel())
}

enum ShowView {
    case PARENT, EDITING, PREVIEW
}


