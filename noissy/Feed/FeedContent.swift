//
//  feedContent.swift
//  noissy

// Content of the feed. 

import SwiftUI
import AVKit

struct FeedContent: View {
    var videoURL: URL
    var feedID: Int?
    var feedViewModel: FeedViewModel
    
    @State private var player: AVPlayer?
    
    @GestureState private var isDragging: Bool = false
    @State private var progress: CGFloat = 0
    @State private var lastDraggedProgress: CGFloat = 0
    @State private var isSeeking: Bool = false
    @State private var isPlaying: Bool = true
    
    var body: some View {
        VStack {
            if let player = player {
                CustomVideoPlayer(player: player)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay(alignment: .bottom) {
                        VStack() {
                            Spacer()
                            VideoMenu(videoURL: videoURL, feedID: feedID, feedViewModel: feedViewModel)
                            VideoSeekerView()
                    }
                }
            }
        }
        .ignoresSafeArea()
        .onTapGesture {
            videoPlayerIsTapped(isPlaying: isPlaying, player: player!, audioPlayer: nil, progress: nil) { playing in
                isPlaying = playing
            }
        }
        .onAppear {
            player = AVPlayer(url: videoURL)
            if let player = player {
                do {
                    try AVAudioSession.sharedInstance().setCategory(.playback)
                } catch(let error) {
                    print(error.localizedDescription)
                }
                
                player.play()
            }
                
            if let player = player {
                player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 20), queue: .main) { time in
                    if let currentPlayerTime = player.currentItem {
                        let totalDuration = currentPlayerTime.duration.seconds
                        let currentDuration = player.currentTime().seconds
                            
                        let calculatedProgress = currentDuration / totalDuration
                            
                        if !isSeeking {
                            progress = calculatedProgress
                            lastDraggedProgress = progress
                        }
                    }
                }
            }
        }
        .onDisappear {
            if let player = player {
                player.pause()
            }
            player = nil
        }
    }
    
    
    @ViewBuilder
    func VideoSeekerView() -> some View {
        let width = max(UIScreen.main.bounds.width * 0.8, 0)
        let progressMax = max(progress, 0)
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                .fill(.black.opacity(0.6))
                .frame(width: width)
            
            RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                .fill(.white.opacity(0.6))
                .frame(width: max(width * progressMax, 0))
        }
        .frame(height: 3)
        .overlay (alignment: .leading) {
            Circle()
                .fill(.clear)
                .frame(width: 15, height: 15)
                .frame(width: 50, height: 50)
                .contentShape(Rectangle())
                .offset(x: width * progress)
                .gesture(
                    DragGesture()
                        .updating($isDragging, body: { _, out, _ in
                            out = true
                        })
                        .onChanged({ value in
                            player?.pause()
                            isPlaying = false
                            
                            let translationX: CGFloat = value.translation.width
                            let calculatedProgress = (translationX / width) + lastDraggedProgress

                            progress = max(min(calculatedProgress, 1), 0)
                            isSeeking = true
                            
                            if let currentPlayerItem = player?.currentItem {
                                let totalDuration = currentPlayerItem.duration.seconds
                                let seekTime = CMTime(seconds: totalDuration * progress, preferredTimescale: 600)
                                player?.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
                            }
                        })
                        .onEnded({ value in
                            lastDraggedProgress = progress
                        
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                isSeeking = false
                            }
                        })
                )
                .frame(width: 15, height: 15)
        }
        .padding()
        .padding(.bottom)
    }
    
}

#Preview {
    FeedContent(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")!, feedID: 1, feedViewModel: FeedViewModel())
}
