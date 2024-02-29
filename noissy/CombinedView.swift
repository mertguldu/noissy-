//
//  CombinedView.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct CombinedView: View {
    @ObservedObject var feedViewModel: FeedViewModel = FeedViewModel()
    
    var body: some View {
        ScrollViewReader{ scrollView in
            ZStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing:0){
                        HomeView(feedViewModel: feedViewModel)
                            .frame(width: UIScreen.main.bounds.width)
                            .id("home")
                        
                        LibraryView(feedViewModel: feedViewModel)
                            .frame(width: UIScreen.main.bounds.width)
                            .id("library")
                            .environment(\.layoutDirection, .leftToRight)
                    }
                    .background( GeometryReader {geometry in
                        Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                    })
                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                        feedViewModel.scrollPosition = value
                        if value.x == -screenWidth {
                            feedViewModel.onPage = "home"
                        } else if value.x == 0  {
                            feedViewModel.onPage = "library"
                        }
                    }
                }
                .scrollTargetBehavior(.paging)
                .environment(\.layoutDirection, .rightToLeft)
                .onChange(of: feedViewModel.onPage) {
                    withAnimation(.easeIn) {
                        scrollView.scrollTo(feedViewModel.onPage)
                    }
                    
                }
                .coordinateSpace(name: "scroll")
            }
        }
    }
}

#Preview {
    CombinedView()
}



