//
//  ShareButton.swift


import SwiftUI

struct ShareButton: View {
    var body: some View {
        VStack {
            ShareLink(item: Image(systemName: "square.and.arrow.up.fill"), preview: SharePreview("Share your video.", image: Image(systemName: "pencil"))) {
                Image(systemName: "square.and.arrow.up.fill")
                    .foregroundStyle(Color.white)
                    .font(.title3)
                    .padding()
                    .fontWeight(.semibold)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
            }
            
            Text("Share")
                .foregroundStyle(.white)
                .font(.caption)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    ShareButton()
        .background(.black)
}
