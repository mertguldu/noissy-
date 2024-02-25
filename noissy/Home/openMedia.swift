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
            logo()
        }
        .padding(.top, -200)
        .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
    }
}

#Preview {
    openMedia(feedViewModel: FeedViewModel())
}
