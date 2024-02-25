//
//  containerView.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct containerView: View {
    @ObservedObject var feedViewModel: FeedViewModel = FeedViewModel()
    @ObservedObject var CoreDataVM: CoreDataViewModel = CoreDataViewModel()
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing:0){
                homeView(feedViewModel: feedViewModel, CoreDataVM: CoreDataVM)
                    .frame(width: UIScreen.main.bounds.width)
                    .id("home")
                
                libraryView(feedViewModel: feedViewModel, CoreDataVM: CoreDataVM)
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
