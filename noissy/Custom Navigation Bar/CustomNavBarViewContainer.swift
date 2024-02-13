//
//  CustomNavBarViewContainer.swift


// You need this to contain the view. Then you put this view inside NavigationLink or NavigationView to get the right properties. That's why container is needed.

import SwiftUI

struct CustomNavBarViewContainer<Content:View>: View {
    let content: Content
    var title: String
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    
    var body: some View {
            ZStack {
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                VStack(spacing:0) {
                    LinkedNavBar(title: title)
                    Spacer()
                }
            }
    }
}

#Preview {
    CustomNavBarViewContainer(title: "NavBar"){
        Text("asd")
            .foregroundStyle(.black)
    }
    
}
