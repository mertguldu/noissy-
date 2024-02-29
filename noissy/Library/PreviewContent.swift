//
//  PreviewContent.swift
//  noissy
//
//  Created by Mert Guldu on 2/27/24.
//

import SwiftUI
import AVKit

struct PreviewContent: View {
    //var uiImage: UIImage
    var videoContentData: NSData?
    
    let scaleUp: CGFloat = 7.0
    let widthAspect: CGFloat = 9.0
    let heightAspect: CGFloat = 16.0
    
    var body: some View {
        let width = UIScreen.main.bounds.width/heightAspect * scaleUp
        let height = UIScreen.main.bounds.width/widthAspect * scaleUp
        
        if let data = videoContentData {
            let url = dataToURL(data: data)
            VideoPlayer(player: AVPlayer(url: url))
                .frame(width: width , height: height)
                .mask {
                    RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                        .frame(width:width, height: height)
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
