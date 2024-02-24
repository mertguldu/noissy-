//
//  noissyHeader.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct noissyHeader: View {
    var body: some View {
        VStack{
            ZStack {
                HStack {
                    Text("Library")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .onTapGesture(perform: {
                            print("Library is clicked")
                        })
                    Spacer()
                }
                .padding()
    
                PageIndicator()
            }
            Spacer()
        }
    }
}

#Preview {
    noissyHeader()
        .background(.black)
}
