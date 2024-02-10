//
//  singleFeedView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct singleFeedView: View {
    let example = Image(systemName: "square.and.arrow.up")
    @Binding var imageIsSelected: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.gray)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .frame(height: UIScreen.main.bounds.height)
            
            VStack(spacing:0){
                HStack{
                    Image(systemName: "chevron.left")
                    .foregroundStyle(Color.white)
                    .opacity(imageIsSelected ? 1.0 : 0.0)
                    .onTapGesture(perform: {
                        withAnimation(.easeOut) {
                            imageIsSelected.toggle()
                        }
                    })
                    
                    Spacer()
                    
                    ShareLink(item: example, preview: SharePreview("Share your REEL", image: example)) {
                        Image(systemName: "square.and.arrow.up")
                            .foregroundStyle(Color.white)
                            
                    }
                }
                .padding()
                .padding(.top, 35)
                
                Spacer()
                HStack{
                    Text("Generated Caption for the content")
                        .font(.title3)
                        .fontWeight(.semibold)
                        .padding()
                    Spacer()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        
    }
}

#Preview {
    @State var imageIsSelected = false

    return singleFeedView(imageIsSelected: $imageIsSelected)
}
