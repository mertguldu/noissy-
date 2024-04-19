//
//  currentSongView.swift
//  noissy
//
//  Created by Mert Guldu on 4/19/24.
//

import SwiftUI

struct currentSongView: View {
    var feedViewModel: FeedViewModel
    
    var body: some View {
        if let audio = feedViewModel.generatedMusic {
            let data = Data(base64Encoded: audio.encodedData!)
            let url = dataToURL2(data: data! as NSData, url: "currentSong.wav")
            favoriteMusicPlay(audioURL: url, imageData: feedViewModel.imagePreviewData, id: -1, feedViewModel: feedViewModel)
        }
    }
}

#Preview {
    currentSongView(feedViewModel: FeedViewModel())
}
