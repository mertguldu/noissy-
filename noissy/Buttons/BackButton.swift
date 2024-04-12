//
//  BackButton.swift


import SwiftUI

struct BackButton: View {
    var action: (() -> Void)?
    var body: some View {
        Button(action: {
            if let act = action {
                act()
            }
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
            }
            .foregroundStyle(Color.white)
        })
    }
}

#Preview {
    BackButton()
        .background(.black)
}
