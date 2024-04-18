//
//  LikeButton.swift
//  noissy
//
//  Created by Mert Guldu on 4/16/24.
//

import SwiftUI

struct LikeButton: View {
    @Binding var showText: Bool
    @Binding var isLiked: Bool
    var feedID: Int?
    var feedViewModel: FeedViewModel = FeedViewModel()
    
    var body: some View {
        Button(action: {
            withAnimation {
                isLiked.toggle()
                
                if let id = feedID {
                    let feed = feedViewModel.ContentLibrary[id]
                    feedViewModel.likeToggle(feed: feed)
                } else {
                    feedViewModel.isLiked.toggle()
                }
                
                if isLiked {
                    showText = true
                    print("music is added to the favorites")
                } else {
                    showText = false
                    print("music is removed from the favorites")
                }
            }
        }, label: {
            Image(systemName: isLiked ? "heart.fill" : "heart")
                .foregroundStyle(isLiked ? Color.red : Color.white)
                .font(.title3)
                .fontWeight(.semibold)
                .frame(width: 50, height: 50)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        })
        .onAppear {
            if let id = feedID {
                let feed = feedViewModel.ContentLibrary[id]
                isLiked = feed.isLiked
                print("onAppear isLiked:", isLiked)
            } else {
                feedViewModel.isLiked = false
            }
        }
    }
}

struct PreviewLikeButton: View {
    @State private var showText = false
    @State private var liked = false
    var body: some View {
        LikeButton(showText: $showText, isLiked: $liked)
    }
}

#Preview {
    PreviewLikeButton()
        .background(.black)
}
