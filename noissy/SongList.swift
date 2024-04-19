//
//  SongList.swift
//  noissy
//
//  Created by Mert Guldu on 4/19/24.
//

import SwiftUI

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

#Preview {
    SongList(feedViewModel: FeedViewModel())
}
