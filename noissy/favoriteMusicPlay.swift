//
//  favoriteMusicPlay.swift
//  noissy
//
//  Created by Mert Guldu on 4/19/24.
//

import SwiftUI
import AVKit

struct favoriteMusicPlay: View {
    var audioURL: URL
    var imageData: Data?
    var id: Int
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var isPlaying: Bool = false
    @State private var progress: Double = .zero
    @State private var audioPlayer: AVAudioPlayer?
    @State private var isSelected: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing:0) {
            HStack {
                if let data = imageData {
                    let uiimage = UIImage(data: data)
                    Image(uiImage: uiimage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 50 , height: 50)
                        .mask {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(width: 50, height: 50)
                        }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                }
                
                Text("Name")
                    .foregroundStyle(.white)
                    .padding()
                
                Spacer()
                
                Button {
                    isPlaying.toggle()
                    feedViewModel.ActiveFavoritePlayer = id
                    
                    if isPlaying {
                        audioPlayer?.play()
                    } else {
                        audioPlayer?.pause()
                    }
                } label: {
                    Image(systemName: (audioPlayer?.isPlaying ?? false) ? "pause.fill" : "play.fill")
                        .foregroundStyle(.white)
                }
                .padding()
            }
    
            Rectangle()
                .fill(.white)
                .frame(width: progress * width, height: 3)
        }
        .background(isSelected ? Color(red: 0.6, green: 0.0, blue: 0.5) : Color.black)
        .onTapGesture {
            isSelected = true
            feedViewModel.selectedFavoritePlayer = id
        }
        .onAppear {
            isSelected = (feedViewModel.selectedFavoritePlayer == id) ? true : false
            DispatchQueue.global().async {
                do {
                    let player = try AVAudioPlayer(contentsOf: audioURL)
                    //DispatchQueue.main.async {
                        audioPlayer = player
                    //}
                } catch {}
            }
            
            Timer.scheduledTimer(withTimeInterval: 1.0 / 20.0, repeats: true) { _ in
                let totalDuration = audioPlayer?.duration
                let currentDuration = audioPlayer?.currentTime
                let calculatedProgress = (currentDuration ?? 0) / (totalDuration ?? 1)
                    
                progress = calculatedProgress
            }
        }
        .onChange(of: feedViewModel.ActiveFavoritePlayer) { activeSongID in
            if id != activeSongID {
                audioPlayer?.pause()
                audioPlayer?.currentTime = .zero
                isPlaying = false
            }
        }
        .onChange(of: feedViewModel.selectedFavoritePlayer) { selectedSongID in
            if id != selectedSongID {
                isSelected = false
            }
        }
        .onDisappear {
            print("asdasdasdasd")
            audioPlayer?.pause()
            if isSelected {
                feedViewModel.selectedFavouriteAudioURL = audioURL
            }
        }
    }
}

#Preview {
    favoriteMusicPlay(audioURL: exampleAudioURL, id: 0, feedViewModel: FeedViewModel())
}
