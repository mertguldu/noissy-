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
        
    var videoURL: URL
    var audioURL: URL
    var duration: Double
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
                        
                    WaveForm(feedViewModel: feedViewModel, audioURL: audioURL, videoDuration: duration)
                        
                }
                .padding(.horizontal, width/2)
                .background(GeometryReader {
                    Color.clear.preference(key: ScrollOffsetKey.self, value: -$0.frame(in: .named("scroll")).origin.x)
                })
                .onPreferenceChange(ScrollOffsetKey.self) { value in
                    updatePlayerTime(value: value, player: player, audioPlayer: audioPlayer, duration: duration, isPlaying: isPlaying) { prog in
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
                    await generateImages(videoURL: videoURL, duration: duration, size: CGSize(width: 50, height: 0)) { image in
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
    let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")
    let audioURL = Bundle.main.url(forResource: "sample2", withExtension: "m4a")
    
    var body: some View {
        VStack {
            TimeLineView(offset: $offset, progress: $progress, isPlaying: $isPlaying, videoURL: videoURL!, audioURL: audioURL!, duration: 15, player: AVPlayer(), audioPlayer: AVAudioPlayer(), feedViewModel: FeedViewModel())
        }
        
    }
}

#Preview {
    PreviewTimeLine()
        .background(.black)
}
