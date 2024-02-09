//
//  homeView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI
import PhotosUI

struct homeView: View {
    
    @State private var selectedImage: PhotosPickerItem? = nil
    @State var selectedImageData: Data? = nil
    
    var body: some View {
        VStack{
            Text("Click to Upload Your REEL")
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
            
            Spacer()
            PhotosPicker(selection: $selectedImage) {
                Circle()
                    .frame(width: 200)
                    .foregroundStyle(Color(red: 0.5, green: 0, blue: 0.5))
            }
            .padding(.top,-50)
            
            
            Spacer()
            Spacer()

        }
    }
}

#Preview {
    homeView()
        .frame(width: 400)
        .background(.black)
}
