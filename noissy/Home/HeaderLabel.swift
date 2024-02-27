//
//  HeaderLabel.swift
//  noissy
//
//  Created by Mert Guldu on 2/27/24.
//

import SwiftUI

struct HeaderLabel: View {
    var body: some View {
        Text("Click to upload your video")
            .foregroundStyle(.white)
            .font(.headline)
            .fontWeight(.bold)
            .padding(.top)
    }
}

#Preview {
    HeaderLabel()
}
