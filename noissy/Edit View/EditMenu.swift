//
//  EditMenu.swift
//  noissy
//
//  Created by Mert Guldu on 4/6/24.
//

import SwiftUI
import AVKit

struct EditMenu: View {
    @Binding var videoVolume: CGFloat
    @Binding var audioVolume: CGFloat

    @State private var showVolumeMenu: Bool = false
    
    
    var body: some View {
        GeometryReader {geomerty in
            let menuHeight = geomerty.safeAreaInsets.bottom
            ZStack {
                if showVolumeMenu {
                    VolumeView(videoVolume: $videoVolume, audioVolume: $audioVolume, showMenu: $showVolumeMenu)
                        .zIndex(1)
                }
                VStack {
                    Spacer()
                    HStack(spacing: 5) {
                        Spacer()
                        Button(action: {
                            
                            print("hkaedad")
                        }, label: {
                            Text("Generate")
                                .foregroundStyle(.white)
                                .padding()
                                .frame(height: menuHeight)
                            
                        })
                        
                        .background(.black)
                        
                        Spacer()
                        Button(action: {
                            showVolumeMenu = true
                        }, label: {
                            Text("Volume")
                                .foregroundStyle(.white)
                                .padding()
                                .frame(height: menuHeight)
                        })
                        
                        .background(.black)
                        Spacer()
                    }
                    .frame(height: menuHeight)
                    .frame(maxWidth: .infinity)
                    .background(.black)
                }
                .zIndex(0)
            }
            //.ignoresSafeArea()
        }
    }
}

struct PreviewEditMenu: View {
    @State var videoVolume: CGFloat = .zero
    @State var audioVolume: CGFloat = .zero
    var body: some View {
        EditMenu(videoVolume: $videoVolume, audioVolume: $audioVolume)
    }
}

#Preview {
    PreviewEditMenu()
}

