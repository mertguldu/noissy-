//
//  GenerateView.swift
//  noissy
//
//  Created by Mert Guldu on 4/16/24.
//

import SwiftUI

struct GenerateView: View {
    @State private var offset: CGFloat = 450
    @Binding var videoVolume: CGFloat
    @Binding var audioVolume: CGFloat
    @Binding var showMenu: Bool
    var feedViewModel: FeedViewModel
    
    let menuHeight: Double = 450
    
    var body: some View {
        menuView(offset: $offset, showMenu: $showMenu, feedViewModel: feedViewModel, menuHeight: menuHeight)
        .overlay {
            VStack(spacing: 40) {
                Spacer()
                VStack(spacing: 5) {
                    HStack {
                        Text("Video Volume")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    
                }
                
                
            }
            .offset(y:offset - menuHeight / 5 )
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                offset = 0
            }
            
        }
    }
}

struct PreviewGenerateView: View {
    @State private var showMenu: Bool = true
    @State private var videoVolume: CGFloat = 1
    @State private var audioVolume: CGFloat = 1
    var body: some View {
        GenerateView(videoVolume: $videoVolume, audioVolume: $audioVolume, showMenu: $showMenu, feedViewModel: FeedViewModel())
    }
}

#Preview {
    PreviewGenerateView()
}
