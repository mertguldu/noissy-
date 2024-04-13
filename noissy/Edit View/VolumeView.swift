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
    @State private var offset: CGFloat = 450
    @Binding var videoVolume: CGFloat
    @Binding var audioVolume: CGFloat
    @Binding var showMenu: Bool
    
    let menuHeight: Double = 450
    
    var body: some View {
        menuView(offset: $offset, showMenu: $showMenu, menuHeight: menuHeight)
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
                    
                    VolumeBox(volume: $videoVolume)
                }
                
                VStack(spacing: 5) {
                    HStack {
                        Text("Audio Volume")
                            .foregroundStyle(.white)
                            .font(.title2)
                            .fontWeight(.bold)
                            .padding(.horizontal)
                        Spacer()
                    }
                    
                    VolumeBox(volume: $audioVolume)
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
    @State private var videoVolume: CGFloat = 1
    @State private var audioVolume: CGFloat = 1
    var body: some View {
        VolumeView(videoVolume: $videoVolume, audioVolume: $audioVolume, showMenu: $showMenu)
    }
}

#Preview {
    PreviewVolumeView()
}


