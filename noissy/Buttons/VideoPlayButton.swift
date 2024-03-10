//
//  VideoPlayButton.swift
//  noissy
//
//  Created by Mert Guldu on 2/28/24.
//

import SwiftUI

struct VideoPlayButton: View {
    var body: some View {
        Image(systemName: "play.fill")
            .foregroundStyle(.white)
            .font(.title)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(Circle())
    }
}

#Preview {
    VideoPlayButton()
}
