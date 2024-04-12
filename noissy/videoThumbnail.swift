//
//  videoThumbnail.swift
//  noissy
//
//  Created by Mert Guldu on 4/6/24.
//

import SwiftUI

struct videoThumbnail: View {
    var imageSequence: [UIImage]
    let imageWidth: Double = 30
    
    var body: some View {
        HStack(spacing:0) {
            ForEach(imageSequence, id:\.self) {index in
                Image(uiImage: index)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: thumbNailWidth, height: height * 0.06)
            }
        }
        .frame(height: height * 0.06)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    videoThumbnail(imageSequence: [])
}
