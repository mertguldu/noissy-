//
//  feedContent.swift
//  noissy
//
//  Created by Mert Guldu on 2/23/24.
//

import SwiftUI

struct feedContent: View {
    var content: UIImage? = nil
    
    var body: some View {
        if let selectedContent = content {
            Image(uiImage: selectedContent)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .background(.clear)
        } else {
            Text("No content is available. Choose a content")
                .font(.title)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    //let exampleContent = UIImage(systemName: "pencil")
    //return feedContent(content: exampleContent)
    //uncomment the above lines to see the UI of this page
    
    feedContent()
}
