//
//  CustomNavBarViewContainer.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

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
            VStack(spacing:0) {
                LinkedNavBar(title: title)
                content
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
    }
}

#Preview {
    CustomNavBarViewContainer(title: "NavBar"){
        Text("asd")
    }
}
