//
//  previewContent.swift
//  noissy
//
//  Created by Mert Guldu on 2/27/24.
//

import SwiftUI

struct previewContent: View {
    var uiImage: UIImage
    
    let scaleUp: CGFloat = 7.0
    let widthAspect: CGFloat = 9.0
    let heightAspect: CGFloat = 16.0
    
    var body: some View {
        let width = UIScreen.main.bounds.width/heightAspect * scaleUp
        let height = UIScreen.main.bounds.width/widthAspect * scaleUp
        
        Image(uiImage: uiImage)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(width: width , height: height)
            .mask {
                RoundedRectangle(cornerSize: CGSize(width: 20, height: 20))
                    .frame(width:width, height: height)
            }
    }
}

#Preview {
    previewContent(uiImage: UIImage(systemName: "pencil")!)
}
