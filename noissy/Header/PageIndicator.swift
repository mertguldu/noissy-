//
//  PageIndicator.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

let screenWidth = UIScreen.main.bounds.width

struct PageIndicator: View {
    @ObservedObject var feedViewModel: FeedViewModel

    var body: some View {
        HStack(alignment:.center, spacing: 20){
            CircleIndicator(color: feedViewModel.selectedTab == 2 ? Color.white : Color.gray)
                .onTapGesture {
                    withAnimation {
                        feedViewModel.selectedTab = 2
                    }
                    print("circle 1 is clicked")
                }
            
            CircleIndicator(color: feedViewModel.selectedTab == 1 ? Color.white : Color.gray)
                .onTapGesture {
                    withAnimation {
                        feedViewModel.selectedTab = 1
                    }
                    print("circle 2 is clicked")
                }
        }
    }
}



#Preview {
    PageIndicator(feedViewModel: FeedViewModel())
        .background(.black)
}
