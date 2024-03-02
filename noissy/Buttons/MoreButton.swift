//
//  MoreButton.swift
//  noissy
//
//  Created by Mert Guldu on 3/2/24.
//

import SwiftUI

struct MoreButton: View {
    var body: some View {
        VStack(spacing:3) {
            ForEach(0..<3) { _ in
                Circle()
                    .frame(width: 4)
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    MoreButton()
        .background(.black)
}
