//
//  CombinedView.swift
//  noissy

// Unites every view and puts them inside a tabview.
// LibraryView is where generated musics are stored along with the corresponding videos.
// HomeView is where photo library can be accessed.
// Scrolling features are edited here.

import SwiftUI

struct CombinedView: View {
    @ObservedObject var feedViewModel: FeedViewModel = FeedViewModel()
    @State var selectedTab: Int = 0
    var body: some View {
        TabView(selection: $selectedTab){
            if !feedViewModel.ContentLibrary.isEmpty{
                LibraryView(feedViewModel: feedViewModel)
                    .frame(width: UIScreen.main.bounds.width)
                    .id("home")
                    .tag(2)
            }
            HomeView(feedViewModel: feedViewModel)
                .frame(width: UIScreen.main.bounds.width)
                .id("home")
                .tag(1)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .disabled(feedViewModel.currentTask)
        .onAppear(perform: {
                UIScrollView.appearance().bounces = false
            selectedTab = feedViewModel.selectedTab
            })
        .onChange(of: feedViewModel.selectedTab) { _ in
            withAnimation {
                selectedTab = feedViewModel.selectedTab
            }
        }
        .onChange(of: selectedTab) { _ in
            withAnimation {
                feedViewModel.selectedTab = selectedTab
            }
        }
        .alert(Text(feedViewModel.errorMessage), isPresented: $feedViewModel.isErrorOccured) {
            Button(action: {
                feedViewModel.isErrorOccured = false
            }, label: {
                Text("OK")
            })
        }
    }
}

#Preview {
    CombinedView()
}



