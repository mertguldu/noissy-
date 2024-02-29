//
//  PreviewView.swift
//  noissy
//
//  Created by Mert Guldu on 2/28/24.
//

import SwiftUI

struct PreviewView: View {
    //let uiImage: UIImage
    var videoData: NSData?
    
    var body: some View {
        ZStack {
            previewContent(videoContentData: videoData)
            VideoPlayButton()
        }
    }
}

#Preview {
    PreviewView()
}
