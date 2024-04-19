//
//  EditView.swift
//  noissy
//
//  Created by Mert Guldu on 4/2/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct EditView: View {
    var videoURL: URL
    @State var audio: APIResponse
    //@State var audioURL: URL
    var duration: Double
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var player: AVPlayer?
    @State private var audioPlayer: AVAudioPlayer?
    @State private var audioData: Data?
    
    @State private var imageSequence: [UIImage] = []
    @State private var progress: CGFloat = 0
    @State private var offset: CGPoint = .zero
    @State private var videoVolume: CGFloat = 1
    @State private var audioVolume: CGFloat = 1
    
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
                            
                                TimeLineView(offset: $offset, progress: $progress, isPlaying: $isPlaying, audio: audio, videoURL: videoURL, videoDuration: duration, player: player, audioPlayer: audioPlayer, feedViewModel: feedViewModel)
                                    .frame(height: height * 0.12 + 30)
                            
                            Spacer()
                        }
                        .zIndex(0)
                        
                        EditMenu(videoVolume: $videoVolume, audioVolume: $audioVolume, feedViewModel: feedViewModel)
                            .zIndex(2)
                        
                        PrevPageButton(feedViewModel: feedViewModel, currentView: .PARENT)
                            .zIndex(1)
                        
                        NextPageButton(feedViewModel: feedViewModel, currentView: .PREVIEW)
                            .zIndex(1)
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.black)
        }
        .onAppear{
            player = AVPlayer(url: videoURL)
            player?.volume = 1.0
            audioPlayer?.volume = 1.0
            feedViewModel.videoVolume = 1.0
            feedViewModel.audioVolume = 1.0
            
            feedViewModel.regenarating = false
            feedViewModel.selectedFavoritePlayer = -1
           
            audioData = Data(base64Encoded: (audio.encodedData)!)
            let audioURL = dataToURL2(data: audioData! as NSData, url: "edit.wav")
            
            feedViewModel.currentAudioURL = audioURL
            
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
                audioPlayer?.currentTime = .zero
                audioPlayer?.play()
            }
        }
        .onChange(of: videoVolume) { value in
            player?.volume = Float(value)
            feedViewModel.videoVolume = Float(value)
        }
        .onChange(of: audioVolume) { value in
            audioPlayer?.volume = Float(value)
            feedViewModel.audioVolume = Float(value)
        }
        .onChange(of:feedViewModel.selectedFavoritePlayer) { id in
            if id == -1 {
                if let generatedMusic = feedViewModel.generatedMusic {
                    audioData = Data(base64Encoded: generatedMusic.encodedData!)
                }
            } else {
                let feed = feedViewModel.ContentLibrary[id]
                audioData = feed.musicData
            }
            if let audioData = audioData {
                let audioURL = dataToURL2(data: audioData as NSData, url: "edit.wav")
                feedViewModel.currentAudioURL = audioURL
                print(id)
                Task{
                    try? prepareAudioPlayer(audioURL: audioURL, completion: { audio in
                        audioPlayer = audio
                        audioPlayer?.currentTime = progress * duration
                    })
                }
            }
        }
        .onChange(of: feedViewModel.showFavouriteMenu) { value in
            print("menu is showed")
            if value {
                player?.pause()
                audioPlayer?.pause()
                isPlaying = false
            }
        }
    }
}



struct PreviewEditView: View {
    @State private var duration: Double?
    @State private var audio: APIResponse?
    var body: some View {
        VStack{
            if let duration = duration {
                if let audio = audio {
                    EditView(videoURL: exampleVideoURL, audio: audio, duration: duration, feedViewModel: FeedViewModel())
                }
            }
        }
        .onAppear {
            Task {
                duration = await videoDuration(videoURL: exampleVideoURL)
                
                let audioData = try Data(contentsOf: exampleAudioURL)
                
                audio = APIResponse(encodedData: audioData.base64EncodedString(), channels: 2, sampleRateHz: 44100.0, duration: 71, sampleFrames: 440288, error: "dsf")
                    
                
            }
        }
    }
}

#Preview {
    PreviewEditView()
}



