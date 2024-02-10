//
//  libraryView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct libraryView: View {
    let numberOfContent = 5
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
                        Rectangle()
                            .stroke(Color.black) //remove the stroke later
                            .fill(.gray)
                            .frame(height: UIScreen.main.bounds.width/3)
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
