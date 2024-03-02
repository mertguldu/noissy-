//
//  ShareButton.swift


import SwiftUI

struct ShareButton: View {
    var body: some View {
        ShareLink(item: Image(systemName: "square.and.arrow.up"), preview: SharePreview("Share your video.", image: Image(systemName: "pencil"))) {
            Image(systemName: "square.and.arrow.up")
                .foregroundStyle(Color.white)
                .font(.title3)
                .padding()
                .fontWeight(.semibold)
                .background(.ultraThinMaterial)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ShareButton()
        .background(.black)
}
