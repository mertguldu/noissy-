//
//  backButton.swift


import SwiftUI

struct backButton: View {
    var action: (() -> Void)? = nil
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
    backButton()
        .background(.black)
}
