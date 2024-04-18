//
//  PrevPageButton.swift
//  noissy
//
//  Created by Mert Guldu on 4/14/24.
//

import SwiftUI

struct PrevPageButton: View {
    @State var feedViewModel: FeedViewModel
    var currentView: ShowView
    
    var body: some View {
        HStack {
            VStack {
                Button(action: {
                    feedViewModel.regenarating = true
                    withAnimation {
                        feedViewModel.currentView = currentView
                    }
                }, label: {
                    //Image(systemName: "arrow.backward")
                        //.foregroundStyle(.white)
                    Text("Back")
                        .foregroundStyle(.white)
                })
                .padding(.horizontal)
                Spacer()
            }
            Spacer()
        }
    }
}

#Preview {
    PrevPageButton(feedViewModel: FeedViewModel(), currentView: .PARENT)
        .background(.black)
}
