//
//  noissy.swift

import SwiftUI

struct noissy: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    var body: some View {
        if feedViewModel.invited {
            NavigationStack {
                ZStack {
                    if !feedViewModel.currentTask && !feedViewModel.ContentLibrary.isEmpty{
                        noissyHeader(feedViewModel: feedViewModel)
                    }
                    CombinedView(feedViewModel: feedViewModel)
                        .padding(.top, 70)
                }
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(mainColor)
                .navigationDestination(isPresented: $feedViewModel.isTaskCompleted) {
                    SingleFeedView(feedViewModel: feedViewModel)
                }
            }
            .tint(.white)
            .edgesIgnoringSafeArea(.all)
            .statusBarHidden(feedViewModel.hideStatusBar)
            .preferredColorScheme(.dark) //for setting the theme of the app, including the status bar color
            .onAppear {
                print("delete meeeeee")
                if feedViewModel.userID == nil {
                    print("user has no id")
                }
            }
            
        } else {
            InvitePage(feedViewModel: feedViewModel)
        }
    }
}

#Preview {
    noissy(feedViewModel: FeedViewModel())
       
}
