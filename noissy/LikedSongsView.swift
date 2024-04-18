//
//  LikedSongsView.swift
//  noissy
//
//  Created by Mert Guldu on 4/17/24.
//

import SwiftUI
import AVKit

struct LikedSongsView: View {
    @Binding var showMenu: Bool
    var feedViewModel: FeedViewModel
    @State private var offset: CGFloat = UIScreen.main.bounds.height * 0.7
    
    let menuHeight: Double = UIScreen.main.bounds.height * 0.7
    
    var body: some View {
        ZStack(alignment: .bottom) {
            menuView(offset: $offset, showMenu: $showMenu, feedViewModel: feedViewModel, menuHeight: menuHeight)
                .zIndex(0)
            
            VStack(spacing:0) {
                HStack {
                    Text("Favourite Songs")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.horizontal, .bottom])
                    Spacer()
                }
                                
                SongList(feedViewModel: feedViewModel)
                
                Spacer()
            }
            .frame(width: width, height: menuHeight * 0.86)
            .background(.black)
            .offset(y: offset)
            .zIndex(1)
        }
        .onAppear {
            withAnimation {
                offset = 0
            }
        }
        .onChange(of: offset) {_ in
            feedViewModel.ActiveFavoritePlayer = nil
        }
        
    }
}


struct SongList: View {
    var feedViewModel: FeedViewModel

    var body: some View {
        ScrollView(.vertical) {
            VStack(spacing:0) {
                ForEach(feedViewModel.ContentLibrary.indices, id: \.self) { i in
                    if feedViewModel.ContentLibrary[i].isLiked {
                        if let musicData = feedViewModel.ContentLibrary[i].musicData {
                            let audioURL = dataToURL2(data: musicData as NSData, url: "favorite\(i).wav")
                            favoriteMusicPlay(audioURL: audioURL, imageData: feedViewModel.ContentLibrary[i].previewImageData, id: i, feedViewModel: feedViewModel)
                        }
                    }
                }
            }
        }
    }
}

struct PreviewLikedSongsView: View {
    @State private var showMenu: Bool = true
    
    var body: some View {
        LikedSongsView(showMenu: $showMenu, feedViewModel: FeedViewModel())
    }
}

#Preview {
    //favoriteMusicPlay(audioURL: URL(string: "a")!, audioPlayer: AVAudioPlayer(), id: 0, feedViewModel: FeedViewModel())
    PreviewLikedSongsView()
}

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
            print("\(id) selected")
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
        .onChange(of: feedViewModel.ActiveFavoritePlayer) { _ in
            if id != feedViewModel.ActiveFavoritePlayer {
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
        .onChange(of: feedViewModel.showMenu) {value in
            if !value {
                audioPlayer?.pause()
            }
        }
        .onDisappear {
            if isSelected {
                print("selected id:", id)
                feedViewModel.selectedFavouriteAudioURL = audioURL
            }
        }
    }
}
