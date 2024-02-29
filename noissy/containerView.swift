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
        ScrollViewReader{ scrollView in
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
            .onAppear {
                withAnimation(.easeInOut(duration: 2).delay(2)) {
                    //scrollView.scrollTo(feedViewModel.scrollToLibrary)
                }
                UIScrollView.appearance().bounces = false
            }
            .navigationDestination(isPresented: $feedViewModel.isTaskCompleted) {
                if let content = feedViewModel.selectedContent{
                
                    singleFeedView(feedViewModel: feedViewModel, contentData: content)
                        //.toolbar(.hidden)
                }
            }
        }
    }
}

#Preview {
    containerView()
}
