//
//  PreviewView.swift
//  noissy


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
