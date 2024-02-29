//
//  ShareButton.swift


import SwiftUI

struct ShareButton: View {
    var body: some View {
        ShareLink(item: Image(systemName: "square.and.arrow.up"), preview: SharePreview("Share your video.", image: Image(systemName: "square.and.arrow.up"))) {
            Label("Share", systemImage: "square.and.arrow.up")
                .foregroundStyle(Color.white)
                .font(.title3)
                .fontWeight(.semibold)
        }
    }
}

#Preview {
    ShareButton()
        .background(.black)
}
