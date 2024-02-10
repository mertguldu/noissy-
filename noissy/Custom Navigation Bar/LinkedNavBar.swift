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
                presentationMode.wrappedValue.dismiss()
            }, label: {
                    Image(systemName: "chevron.left")
                    .foregroundStyle(Color.white)
                })
            .hidden()
            
        }.padding(.horizontal)
            .padding(.bottom, 5)
            .frame(maxWidth: .infinity)
            .background(.clear)
    }
}

#Preview {
    LinkedNavBar(title: "Text")
        .background(.green)
    
}
