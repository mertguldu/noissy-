//
//  PageSwitching.swift
//  noissy
//
//  Created by Mert Guldu on 4/12/24.
//

import SwiftUI

struct PageSwitching: View {
    
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        VStack {
            switch feedViewModel.currentView {
            case .PARENT:
                noissy(feedViewModel: feedViewModel)
            case .SUBVIEW1:
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
                .transition(.backslide)
                
            case .SUBVIEW2:
                NavigationStack {
                    if let selectedMovie = feedViewModel.selectedMovie {
                        if let generatedMusic = feedViewModel.generatedMusic {
                            let audioData = Data(base64Encoded: generatedMusic.encodedData!)
                            let audioURL = dataToURL2(data: audioData! as NSData, url: "audioGen.wav")
                            SingleFeedView(videoURL: selectedMovie.url!, audioURL: audioURL, feedViewModel: feedViewModel)
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
    PageSwitching(feedViewModel: FeedViewModel())
}

enum ShowView {
    case PARENT, SUBVIEW1, SUBVIEW2
}

extension AnyTransition {
    static var backslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))}
    
    static var bottomslide: AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .bottom))}
}
