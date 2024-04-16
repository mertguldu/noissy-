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
    var body: some View {
        Button(action: {
            withAnimation {
                isLiked.toggle()
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
                .frame(width: 55, height: 55)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        })
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
