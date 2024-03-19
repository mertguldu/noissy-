//
//  VideoMenu.swift
//  noissy

// Share and Delete buttons are here. This view is placed in the FeedContent view.

import SwiftUI

struct VideoMenu: View {
    var feedID: Int?
    var url: URL?
    var feedViewModel: FeedViewModel
    
    @State var img: UIImage?
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing:20) {
                if let id = feedID {
                    if let url = url {
                        ShareButton(movieURL: url, previewImage: img)
                    }
                    DeleteButton(feedID: id, feedViewModel: feedViewModel)
                } else {
                    if let url = url {
                        if let imageData = feedViewModel.imagePreviewData {
                            if let img = UIImage(data: imageData) {
                                ShareButton(movieURL: url, previewImage: img)
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
            if let id = feedID {
                if let pngData = feedViewModel.ContentLibrary[id].previewImageData {
                    img = UIImage(data: pngData)
                }
            }
        }
        .onDisappear {
            img = nil
        }
    }
}

#Preview {
    VideoMenu(feedViewModel: FeedViewModel())
}
