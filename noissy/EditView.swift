//
//  EditView.swift
//  noissy
//
//  Created by Mert Guldu on 4/2/24.
//

import SwiftUI
import AVKit
import AVFoundation

let width = (UIScreen.current?.bounds.width ?? 0)
let height = (UIScreen.current?.bounds.height ?? 0)

let thumbNailWidth = width * 0.06
let numberOfThumbNail = 20




struct EditView: View {
    var feedViewModel: FeedViewModel = FeedViewModel()
    var videoURL: URL
    var audioURL: URL
    var duration: Double
    
    @State private var player: AVPlayer?
    @State private var audioPlayer: AVAudioPlayer?
    
    @State private var imageSequence: [UIImage] = []
    @State private var progress: CGFloat = 0
    @State private var offset: CGPoint = .zero
    @State private var volume: CGFloat = 1
    
    @State private var isPlaying: Bool = true
    @State private var isNext: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack(alignment: .center) {
                if let player = player {
                    if let audioPlayer = audioPlayer {
                        VStack(spacing: 0) {
                            CustomVideoPlayer(player: player)
                                .frame(width: width * 0.65, height: height * 0.65)
                                .clipShape(RoundedRectangle(cornerRadius: 25.0))
                                .onTapGesture {
                                    videoPlayerIsTapped(isPlaying: isPlaying, player: player, audioPlayer: audioPlayer, progress: progress) { playing in
                                        isPlaying = playing
                                    }
                                }
                            
                            Spacer()
                            
                            TimeLineView(offset: $offset, progress: $progress, isPlaying: $isPlaying, videoURL: videoURL, audioURL: audioURL, duration: duration, player: player, audioPlayer: audioPlayer, feedViewModel: feedViewModel)
                                .frame(height: height * 0.12 + 30)
                            
                            Spacer()
                        }
                        .zIndex(0)
                    }
                    
                    EditMenu(volume: $volume)
                        .zIndex(1)
                    
                    NextPageButton(feedViewModel: feedViewModel, currentView: .SUBVIEW2)
                        .zIndex(1)                        
                }
            }
            .background(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear{
            player = AVPlayer(url: videoURL)
            player?.volume = 1.0
            feedViewModel.isTaskCompleted = true
            Task{
                try? prepareAudioPlayer(audioURL: audioURL, completion: { audio in
                    audioPlayer = audio
                })

                
            }
                    
            if let player = player {
                player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 50), queue: .main) { time in
                    let currentDuration = player.currentTime().seconds
                    let calculatedProgress = currentDuration / duration
                    offset = CGPoint(x: progress * CGFloat(thumbNailWidth * CGFloat(numberOfThumbNail)), y: 0)
                    progress = calculatedProgress
                }
            }
        }
        .onDisappear {
            player?.pause()
            audioPlayer?.pause()
        }
        .onChange(of: progress) { _ in
            if progress == 0.0 && isPlaying {
                audioPlayer?.play()
            }
            
        }
        .onChange(of: volume) { value in
            player?.volume = Float(value)
        }
    }
}



struct PreviewEditView: View {
    let videoURL = URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")
    let audioURL = Bundle.main.url(forResource: "sample2", withExtension: "m4a")
    @State private var duration: Double?
    var body: some View {
        VStack{
            if let duration = duration {
                EditView(videoURL: videoURL!, audioURL: audioURL!, duration: duration)
            }
        }
            .onAppear {
                Task {
                    duration = await videoDuration(videoURL: videoURL!)
                }
            }
    }
}

#Preview {
    PreviewEditView()
}



