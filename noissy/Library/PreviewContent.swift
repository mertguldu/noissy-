//
//  PreviewContent.swift
//  noissy

// Content of the PreviewView

import SwiftUI
import AVKit

struct PreviewContent: View {
    var imageData: NSData?
    
    let scaleUp: CGFloat = 7.0
    let widthAspect: CGFloat = 9.0
    let heightAspect: CGFloat = 16.0
    
    var body: some View {
        let width = UIScreen.main.bounds.width/heightAspect * scaleUp
        let height = UIScreen.main.bounds.width/widthAspect * scaleUp
        
        if let data = imageData {
            if let uiimage = UIImage(data: data as Data) {
                Image(uiImage: uiimage)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: width , height: height)
                    .mask {
                        RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                            .frame(width:width, height: height)
                    }
            }
        } else {
            ZStack {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .foregroundStyle(.gray)
                    .frame(width:width, height: height)
                Text("Preview")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
    }
}

#Preview {
    PreviewContent()
}
