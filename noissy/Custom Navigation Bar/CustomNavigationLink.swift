//
//  CustomNavigationLink.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct CustomNavigationLink<Label:View, Destination:View>: View {
    let label: Label
    let destination: Destination
    private var title: String
    
    init(title:String, @ViewBuilder destination: () -> Destination, @ViewBuilder label: () -> Label) {
        self.title = title
        self.destination = destination()
        self.label = label()
    }
    
    var body: some View {
        NavigationLink {
            CustomNavBarViewContainer(title: title) {
                destination
            }
            .toolbar(.hidden)
        } label: {
            label
        }
        
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}
#Preview {
    NavigationView {
        CustomNavigationLink(title: "Title") {
            Text("destination")
        } label: {
            Text("label")
        }
        
    }
    

}
