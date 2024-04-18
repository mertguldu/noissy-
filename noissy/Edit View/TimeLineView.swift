//
//  TimeLineView.swift
//  noissy
//
//  Created by Mert Guldu on 4/11/24.
//

import SwiftUI
import AVKit

struct TimeLineView: View {
    @Binding var offset: CGPoint
    @Binding var progress: CGFloat
    @Binding var isPlaying: Bool
        
    var audio: APIResponse
    var videoURL: URL
    var videoDuration: Double
    var player: AVPlayer
    var audioPlayer: AVAudioPlayer
    var feedViewModel: FeedViewModel
    
    @State private var imageSequence: [UIImage] = []

    var body: some View {
       ZStack {
           RoundedRectangle(cornerRadius: 50)
               .fill(.white)
               .frame(width: 4, height: (height * 0.12) + 30)
           .zIndex(1.0)
            
           ScrollableView($offset, animationDuration: 0, showsScrollIndicator: false, axis: .horizontal) {
                VStack(alignment: .leading, spacing: 10) {
                    videoThumbnail(imageSequence: imageSequence)
                      
                    WaveForm(audio: audio, videoDuration: videoDuration, feedViewModel: feedViewModel)
                       
                        
                }
                .padding(.horizontal, width/2)
                .background(GeometryReader {
                    Color.clear.preference(key: ScrollOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.x)
                })
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    updatePlayerTime(value: value, player: player, audioPlayer: audioPlayer, duration: videoDuration, isPlaying: isPlaying) { prog in
                        progress = prog
                    }
                }
            }
            .coordinateSpace(name: "scroll")
            .gesture(
                DragGesture()
                    .onChanged({ _ in
                        player.pause()
                        audioPlayer.pause()
                        isPlaying = false
                    })
            )
            .zIndex(0.0)
        }
        .onAppear {
            if imageSequence.isEmpty {
                Task {
                    await generateImages(videoURL: videoURL, duration: videoDuration, size: CGSize(width: 50, height: 0)) { image in
                        imageSequence.append(image)
                        if imageSequence.count == numberOfThumbNail {
                            player.play()
                            audioPlayer.play()
                        }
                    }
                }
            }
        }
    }
}

struct PreviewTimeLine: View {
    @State private var offset: CGPoint = .zero
    @State private var progress: CGFloat = .zero
    @State private var isPlaying: Bool = false
    @State private var audio: APIResponse?
    
    var body: some View {
        VStack {
            if let audio = audio {
                TimeLineView(offset: $offset, progress: $progress, isPlaying: $isPlaying, audio: audio, videoURL: exampleVideoURL, videoDuration: 15, player: AVPlayer(), audioPlayer: AVAudioPlayer(), feedViewModel: FeedViewModel())
            }
        }
        .onAppear {
            Task {
                let audioData = try Data(contentsOf: exampleAudioURL)
                
                audio = APIResponse(encodedData: audioData.base64EncodedString(), channels: 2, sampleRateHz: 44100.0, duration: 70.0, sampleFrames: 440288, error: "dsf")
            }
        }
    }
}

#Preview {
    PreviewTimeLine()
        .background(.black)
}
