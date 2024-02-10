//
//  feedView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct feedView: View {
    @State var imageText: String
    let example = Image(systemName: "square.and.arrow.up")

    
    var body: some View {
        VStack {
            ZStack {
                
                Rectangle()
                    .fill(.gray)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                VStack{
                    HStack{
                        Spacer()
                        ShareLink(item: example, preview: SharePreview("Share your REEL", image: example)) {
                            Image(systemName: "square.and.arrow.up")
                                .foregroundStyle(Color.white)
                                .padding()
                        }
                    }
                    Spacer()
                    HStack{
                        Text("Generated Caption for the content")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .padding()
                        Spacer()
                    }
                }
            }
            
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.1, green: 0.0, blue: 0.1))
    }
}

#Preview {
    feedView(imageText: "")
}
