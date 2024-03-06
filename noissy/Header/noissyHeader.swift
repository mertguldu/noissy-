//
//  noissyHeader.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import SwiftUI

struct noissyHeader: View {
    @ObservedObject var feedViewModel: FeedViewModel
    var body: some View {
        VStack{
            ZStack {
                HStack {
                    Button {
                        withAnimation {
                            feedViewModel.selectedTab = 2
                        }
                        print("Library is clicked")
                    } label: {
                        Text("Library")
                            .fontWeight(.bold)
                            .foregroundStyle(feedViewModel.selectedTab == 2 ? Color.white : Color.gray)
                    }
                    Spacer()
                }
                .padding()
    
                PageIndicator(feedViewModel: feedViewModel)
            }
            Spacer()
        }
    }
}

#Preview {
    noissyHeader(feedViewModel: FeedViewModel())
        .background(.black)
}
