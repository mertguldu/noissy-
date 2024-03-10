//
//  ShareButton.swift


import SwiftUI

struct ShareButton: View {
    var movieURL: URL?
    var previewImage : UIImage?
    var body: some View {
        if let url = movieURL {
            if let previewImage = previewImage {
                ShareLink(item: url, preview: SharePreview("Share your video.", image: Image(uiImage: previewImage))) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundStyle(Color.white)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .frame(width: 55, height: 55)
                        .background(.ultraThinMaterial)
                        .clipShape(Circle())
                }
            }
        }
    }
}

#Preview {
    ShareButton()
}
