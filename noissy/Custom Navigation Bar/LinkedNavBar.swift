//
//  LinkedNavBar.swift


import SwiftUI

struct LinkedNavBar: View {
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        HStack(alignment: .center) {
            BackButton {
                presentationMode.wrappedValue.dismiss()
            }
            Spacer()
        }.padding()
            .frame(maxWidth: .infinity)
            .background(.clear)
    }
}

#Preview {
    LinkedNavBar()
        .background(.green)
    
}
