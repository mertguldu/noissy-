//
//  ShareButton.swift


import SwiftUI

struct ShareButton: View {
    var movieURL: URL
    var previewImage : UIImage
    var body: some View {
            let movie = Movie(url: movieURL)
                ShareLink(item: movie, preview: SharePreview("Share your video.", image: Image(uiImage: previewImage))) {
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

#Preview {
    ShareButton(movieURL: URL(string: "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerJoyrides.mp4")!, previewImage: UIImage(systemName: "pencil")!)
        .background(.black)
}
