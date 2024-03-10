//
//  VideoMenu.swift
//  noissy
//
//  Created by Mert Guldu on 3/2/24.
//

import SwiftUI

struct VideoMenu: View {
    var feedID: Int?
    var url: URL?
    var feedViewModel: FeedViewModel
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing:20) {
                if let id = feedID {
                    if let url = url {
                        if let pngData = feedViewModel.ContentLibrary[id].previewImageData {
                            let img = UIImage(data: pngData)
                            ShareButton(movieURL: url, previewImage: img)
                        }
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
    }
}

#Preview {
    VideoMenu(feedViewModel: FeedViewModel())
}
