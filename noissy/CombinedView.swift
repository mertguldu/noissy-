//
//  CombinedView.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct CombinedView: View {
    @ObservedObject var feedViewModel: FeedViewModel = FeedViewModel()
    @State var selectedTab = 1
    var body: some View {
        
        TabView(selection: $selectedTab){
            LibraryView(feedViewModel: feedViewModel)
                .frame(width: UIScreen.main.bounds.width)
                .id("home")
                .tag(2)
            HomeView(feedViewModel: feedViewModel)
                .frame(width: UIScreen.main.bounds.width)
                .id("home")
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .onAppear(perform: {
                UIScrollView.appearance().bounces = false
            })
    }
}

#Preview {
    CombinedView()
}



