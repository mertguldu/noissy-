//
//  openMedia.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI
import PhotosUI

struct openMedia: View {
    //For opening the photo library
    @ObservedObject var feedViewModel: FeedViewModel

    var body: some View {
        PhotosPicker(selection: $feedViewModel.imageSelection, matching:.any(of: [.images, .videos])) {
            Circle()
                .frame(width: 200)
                .foregroundStyle(Color(red: 0.5, green: 0, blue: 0.5))
                .overlay(Image("logo-crop").resizable().frame(width: 125, height: 125))
        }
        .padding(.top, -200)
        .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
    }
}

#Preview {
    openMedia(feedViewModel: FeedViewModel())
}
