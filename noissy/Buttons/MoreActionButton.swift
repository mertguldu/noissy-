//
//  MoreActionButton.swift
//  noissy
//
//  Created by Mert Guldu on 3/2/24.
//

import SwiftUI

struct MoreActionButton: View {
    var body: some View {
        VStack(spacing:3) {
            ForEach(0..<3) { _ in
                Circle()
                    .frame(width: 4)
                    .foregroundStyle(.white)
            }
        }
        .frame(width: 55, height: 55)
        .background(.ultraThinMaterial)
        .clipShape(Circle())
        .onTapGesture {
            print("more actions button is clicked")
        }
    }
}

#Preview {
    MoreActionButton()
}
