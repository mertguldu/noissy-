//
//  PreviewView.swift
//  noissy
//
//  Created by Mert Guldu on 2/28/24.
//

import SwiftUI

struct PreviewView: View {
    let uiImage: UIImage
    var body: some View {
        ZStack {
            previewContent(uiImage: uiImage)
            VideoPlayButton()
        }
    }
}

#Preview {
    PreviewView(uiImage: UIImage(systemName: "pencil")!)
}
