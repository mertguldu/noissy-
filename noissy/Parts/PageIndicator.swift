//
//  PageIndicator.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct PageIndicator: View {
    var body: some View {
        HStack(alignment:.center, spacing: 20){
            CircleIndicator(color: .white)
                .onTapGesture(perform: {
                    print("page indicator 1")
                })
            
            CircleIndicator(color: .white)
                .onTapGesture(perform: {
                    print("page indicator 2")
                })
        }
    }
}

#Preview {
    PageIndicator()
        .background(.black)
}
