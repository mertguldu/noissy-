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
                            .foregroundStyle(.white)
                            .opacity(feedViewModel.selectedTab == 2 ? 1 : 0.5)
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
