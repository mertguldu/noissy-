//
//  menuView.swift
//  noissy
//
//  Created by Mert Guldu on 4/8/24.
//

import SwiftUI

struct menuView: View {
    @Binding var offset: CGFloat
    @Binding var showMenu: Bool
    var feedViewModel: FeedViewModel
    var menuHeight: Double
    
    var body: some View {
        let visibilty = (1 - offset / menuHeight)
            Rectangle()
                .fill(.black)
                .opacity(0.5 * visibilty)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .onTapGesture {
                    withAnimation {
                        offset = menuHeight
                        showMenu = false
                    }
                }
                .overlay {
                    VStack {
                        Spacer()
                        MenuBox(menuHeight: menuHeight)
                            .offset(y:offset)
                            .gesture(
                                DragGesture()
                                    .onChanged({ value in
                                        let translationY = value.translation.height
                                        if translationY >= 0 {
                                            offset = translationY
                                        }
                                    })
                                    .onEnded({ value in
                                        let translationY = value.translation.height
                                        
                                        if translationY > menuHeight * 0.2 {
                                            withAnimation {
                                                offset = menuHeight
                                                showMenu = false
                                            }
                                        } else {
                                            withAnimation {
                                                offset = 0
                                                showMenu = true
                                            }
                                        }
                                    })
                            )
                    }
                }
                .ignoresSafeArea()
        
    }
}

struct MenuBox: View {
    var menuHeight: Double
    
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 10)
                .fill(.black)
                .frame(height: menuHeight)
            VStack {
                RoundedRectangle(cornerRadius: 15)
                    .fill(.white)
                    .frame(width: 100, height: 4)
                    .padding()
                Spacer()
            }
            .frame(height: menuHeight)
            
        }
    }
}

struct PreviewMenuView: View {
    @State private var offset_ex: CGFloat = .zero
    @State private var showMenu: Bool = true
    var body: some View {
        menuView(offset: $offset_ex, showMenu: $showMenu, feedViewModel: FeedViewModel(), menuHeight: 200)
    }
}


#Preview {
    PreviewMenuView()
}
