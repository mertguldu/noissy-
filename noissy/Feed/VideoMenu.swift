//
//  VideoMenu.swift
//  noissy

// Share and Delete buttons are here. This view is placed in the FeedContent view.

import SwiftUI

struct VideoMenu: View {
    var videoURL: URL
    var feedID: Int?
    var feedViewModel: FeedViewModel
    
    @State var img: UIImage?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing:20) {
                if let img = img {
                    ShareButton(movieURL: videoURL, previewImage: img)
                    if let id = feedID {
                        DeleteButton(feedID: id, feedViewModel: feedViewModel)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            generateImageFromVideo(videoURL: videoURL, videoDuration: 0, progress: 0, size: CGSize(width: 300, height: 0), completion: { image in
                img = image
            })
        }
        .onDisappear {
            img = nil
        }
    }
}

#Preview {
    VideoMenu(videoURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")!, feedViewModel: FeedViewModel())
        .background(.black)
}
