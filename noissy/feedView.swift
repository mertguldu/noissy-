//
//  feedView.swift
//  noissy
//
//  Created by Mert Guldu on 2/10/24.
//

import SwiftUI

struct feedView: View {
    @State var imageText: String
    @State var scrollTo: Int
    @State var imageIsSelected = false
    
    var body: some View {
        ScrollViewReader{ scrollView in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing:0){
                    ForEach(0..<10, id: \.self){ i in
                        singleFeedView(imageIsSelected: $imageIsSelected)
                            .id(i)
                    }.onAppear(perform: {
                        scrollView.scrollTo(scrollTo)
                    })
                }
            }.scrollTargetBehavior(.paging)
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(red: 0.1, green: 0.0, blue: 0.1))
        }
        
    }
}

#Preview {
    feedView(imageText: "", scrollTo: 0)
}
