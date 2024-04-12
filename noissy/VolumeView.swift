//
//  VolumeView.swift
//  noissy
//
//  Created by Mert Guldu on 4/7/24.
//

import SwiftUI
import AVKit
import AVFoundation

struct VolumeView: View {
    @State private var offset: CGFloat = 300
    @Binding var volume: CGFloat
    @Binding var showMenu: Bool
    
    let menuHeight: Double = 300
    
    var body: some View {
        menuView(offset: $offset, showMenu: $showMenu, menuHeight: menuHeight)
        .overlay {
            VStack() {
                Spacer()
                VolumeBox(volume: $volume)
            }
            .offset(y:offset - menuHeight/2)
        }
        .ignoresSafeArea()
        .onAppear {
            withAnimation {
                offset = 0
            }
            
        }
    }
}

struct VolumeBox: View {
    @Binding var volume: CGFloat
    
    var body: some View {
        ZStack {
            CustomSlider(progress: $volume)
                .zIndex(1)
            
            RoundedRectangle(cornerRadius: 15)
                .fill(.gray)
                .frame(height: 100)
                .padding(.horizontal, 5)
                .zIndex(0)
        }
        
    }
}

struct PreviewVolumeView: View {
    @State private var showMenu: Bool = true
    @State private var volume: CGFloat = 1
    var body: some View {
        VolumeView(volume: $volume, showMenu: $showMenu)
    }
}

#Preview {
    PreviewVolumeView()
}


