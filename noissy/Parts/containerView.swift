//
//  containerView.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct containerView: View {
    @ObservedObject var feedViewModel: FeedViewModel = FeedViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing:0){
                homeView(feedViewModel: feedViewModel)
                    .frame(width: UIScreen.main.bounds.width)
                    .id("home")
                
                libraryView(feedViewModel: feedViewModel)
                    .frame(width: UIScreen.main.bounds.width)
                    .id("library")
                    .environment(\.layoutDirection, .leftToRight)
            }
        }
        .scrollTargetBehavior(.paging)
        .environment(\.layoutDirection, .rightToLeft)
        .onAppear { UIScrollView.appearance().bounces = false }
    }
}

#Preview {
    containerView()
}
