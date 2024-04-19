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
                    Text("New Song")
                        .foregroundStyle(.white)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding([.horizontal, .bottom])
                    Spacer()
                }
                currentSongView(feedViewModel: feedViewModel)
                    .padding(.bottom)
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
            feedViewModel.showFavouriteMenu = true
            withAnimation {
                offset = 0
            }
        }
        .onDisappear {
            feedViewModel.showFavouriteMenu = false
        }
        .onChange(of: offset) {_ in
            feedViewModel.ActiveFavoritePlayer = -1
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
    PreviewLikedSongsView()
}


