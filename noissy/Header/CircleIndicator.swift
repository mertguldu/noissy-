//
//  CircleIndicator.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct CircleIndicator: View {
    var color: Color = .white
    
    var body: some View {
        Circle()
            .foregroundStyle(color)
            .frame(width: 8)
    }
}

#Preview {
    CircleIndicator()
        .background(.black)
}
