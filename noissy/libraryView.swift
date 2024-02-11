//
//  libraryView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct libraryView: View {
    let numberOfContent = selectedImageLibrary.count
    private let threeColumnGrid = [
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
            GridItem(.flexible(minimum: 40), spacing: 0),
        ]
    
    var body: some View {
        VStack {
            LazyVGrid(columns: threeColumnGrid, spacing: 0) {
                ForEach(0..<numberOfContent, id: \.self) {i in
                    
                    CustomNavigationLink(title: "") {
                        feedView(imageText: "image \(i)", scrollTo: i)
                            
                    } label: {
                        Image(uiImage: selectedImageLibrary[i])
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width/3, height: UIScreen.main.bounds.width/3)
                            .background(.black)
                            .id(i)
                    }
                }
            }
            Spacer()
        }
    }
}



#Preview {
    libraryView()
}
