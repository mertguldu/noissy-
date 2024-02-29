//
//  feedContent.swift
//  noissy
//
//  Created by Mert Guldu on 2/23/24.
//

import SwiftUI
import AVKit

struct FeedContent: View {
    var contentData: NSData? = nil
    
    var body: some View {
        if let data = contentData {
            let cacheURL = dataToURL(data: data)
            VideoPlayer(player: AVPlayer(url: cacheURL))
        } else {
            ZStack {
                Rectangle()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(.gray)
                Text("Video Content")
                    .font(.title)
                    .fontWeight(.bold)
            }
            
                
            
        }
        
    }
}

#Preview {
    //let exampleContent = UIImage(systemName: "pencil")
    //return feedContent(content: exampleContent)
    //uncomment the above lines to see the UI of this page
    
    FeedContent()
}
