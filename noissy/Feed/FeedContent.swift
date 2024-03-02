//
//  feedContent.swift
//  noissy


import SwiftUI
import AVKit

struct FeedContent: View {
    var contentData: NSData? = nil
    var feedID: Int?
    var feedViewModel: FeedViewModel
    
    @State private var player: AVPlayer?
    
    @GestureState private var isDragging: Bool = false
    @State private var progress: CGFloat = 0
    @State private var lastDraggedProgress: CGFloat = 0
    @State private var isSeeking: Bool = false
    @State private var isPlaying: Bool = true
    
    var body: some View {
        if let data = contentData {
            let cacheURL = dataToURL(data: data)
            VStack {
                if let player = player {
                    CustomVideoPlayer(player: player)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .overlay(alignment: .bottom) {
                            VStack() {
                                Spacer()
                                VideoMenu(feedID: feedID, feedViewModel: feedViewModel)
                                VideoSeekerView()
                            }
                        }
                }
            }
            .onTapGesture {
                if isPlaying {
                    player?.pause()
                    isPlaying = false
                    print("pause")
                } else {
                    player?.play()
                    isPlaying = true
                    print("resume")
                }
            }
            .onAppear {
                player = AVPlayer(url: cacheURL)
                player!.play()
                
                if let player = player {
                    player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 5), queue: .main) { time in
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
                player!.pause()
            }
                
        } else {
            ZStack {
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.gray)
                Text("Video Content")
                    .font(.title)
                    .fontWeight(.bold)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
    
    
    @ViewBuilder
    func VideoSeekerView() -> some View {
        let width = UIScreen.main.bounds.width * 0.8
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                .fill(.black)
                .frame(width: width)
            
            RoundedRectangle(cornerSize: CGSize(width: 50, height: 50))
                .fill(.white)
                .frame(width: max(width * progress, 0))
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
                            let translationX: CGFloat = value.translation.width
                            let calculatedProgress = (translationX / width) + lastDraggedProgress

                            progress = max( min(calculatedProgress, 1), 0 )
                            isSeeking = true
                        })
                        .onEnded({ value in
                            lastDraggedProgress = progress
                            
                            if let currentPlayerItem = player?.currentItem {
                                let totalDuration = currentPlayerItem.duration.seconds
                                
                                player?.seek(to: .init(seconds: totalDuration * progress, preferredTimescale: 1))
                            }
                            
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
    FeedContent(feedViewModel: FeedViewModel())
}
