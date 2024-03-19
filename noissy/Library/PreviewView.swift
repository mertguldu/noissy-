//
//  PreviewView.swift
//  noissy

// video previews as images. 

import SwiftUI

struct PreviewView: View {
    var imageData: NSData?
    
    var body: some View {
        ZStack {
            PreviewContent(imageData: imageData)
            VideoPlayButton()
        }
    }
}

#Preview {
    PreviewView()
}
