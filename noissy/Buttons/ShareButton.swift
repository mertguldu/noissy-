//
//  ShareButton.swift


import SwiftUI

struct ShareButton: View {
    var body: some View {
        ShareLink(item: Image(systemName: "square.and.arrow.up"), preview: SharePreview("Share your video.", image: Image(systemName: "pencil"))) {
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
    ShareButton()
}
