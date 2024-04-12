//
//  NextPageButton.swift
//  noissy
//
//  Created by Mert Guldu on 4/11/24.
//

import SwiftUI

struct NextPageButton: View {
    @State var feedViewModel: FeedViewModel
    var currentView: ShowView
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Button(action: {
                    withAnimation {
                        feedViewModel.currentView = currentView
                    }
                }, label: {
                    Text("Done")
                        .foregroundStyle(.white)
                })
                .padding(.horizontal)
                Spacer()
            }
        }
    }
}

struct PreviewCustomNavigation: View {
    @State var isNext: Bool = false
    var body: some View {
        NextPageButton(feedViewModel: FeedViewModel(), currentView: .PARENT)
            .background(.black)
    }
}


#Preview {
    PreviewCustomNavigation()
}

