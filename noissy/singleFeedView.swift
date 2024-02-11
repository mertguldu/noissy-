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
    @State var image: UIImage
    
    var body: some View {
        ZStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            
            
            VStack(spacing:0){
                HStack{
                    Image(systemName: "chevron.left")
                    .foregroundStyle(Color.white)
                    .opacity(imageIsSelected ? 1.0 : 0.0)
                    .onTapGesture(perform: {
                        if let image = selectedImage {
                            selectedImageLibrary.append(image)
                            selectedImage = nil
                        }
                        print(selectedImageLibrary.count)
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
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                }
            }
            .padding()
        }
        .ignoresSafeArea()
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(Color(red: 0.2, green: 0.0, blue: 0.2))
        
    }
}


