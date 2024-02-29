//
//  feedContent.swift
//  noissy
//
//  Created by Mert Guldu on 2/23/24.
//

import SwiftUI
import AVKit

struct FeedContent: View {
    var contentData: NSData? = nil
    
    var body: some View {
        if let data = contentData {
            let cacheURL = dataToURL(data: data)
            let player: AVPlayer = AVPlayer(url: cacheURL)
            CustomVideoPlayer(player: player)
                .onAppear {
                    player.play()
                }
                .onDisappear {
                    player.pause()
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
        }
    }
}

#Preview {
   FeedContent()
}
