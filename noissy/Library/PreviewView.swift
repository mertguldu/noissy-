//
//  PreviewView.swift
//  noissy
//
//  Created by Mert Guldu on 2/28/24.
//

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
