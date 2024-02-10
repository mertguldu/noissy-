//
//  LinkedNavBar.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct LinkedNavBar: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    
    var body: some View {
        HStack(alignment: .center) {
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }, label: {
                    Image(systemName: "chevron.left")
                    .foregroundStyle(Color.white)
                })
            Spacer()
                Text(title)
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            Spacer()
            
            Button(action: {
                print("share button is clicked")
            }, label: {
                Image(systemName: "square.and.arrow.up")
                    .foregroundStyle(Color.white)
            })
            
        }.padding()
            .frame(maxWidth: .infinity)
            .background(Color(red: 0.3, green: 0.0, blue: 0.3)
                .ignoresSafeArea(edges: .top))
    }
}

#Preview {
    LinkedNavBar(title: "Text")
}
