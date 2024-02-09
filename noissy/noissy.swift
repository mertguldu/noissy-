//
//  ContentView.swift
//  noissy
//
//  Created by Mert Guldu on 1/25/24.
//

import SwiftUI
import PhotosUI

struct noissy: View {
    @State var pageNumber: Int = 1
    @State private var scrollPosition: CGPoint = .zero
    @State var libraryTextSize: CGFloat = 0
    @State var itemOpacity: CGFloat = 0.5
    var body: some View {
        ScrollViewReader { scrollView in
                ZStack{
                    VStack{
                        HStack(spacing: 20){
                            Circle()
                                .foregroundStyle(.white)
                                .opacity(pageNumber == 0 ? 1.0: 0.5)
                                .frame(width: pageNumber == 0 ? 7 : 6)
                                .onTapGesture(perform: {
                                    withAnimation(.easeIn) {
                                        scrollView.scrollTo("library")
                                        pageNumber = 0
                                    }
                                })
                            Circle()
                                .foregroundStyle(.white)
                                .opacity(pageNumber == 1 ? 1.0: 0.5)
                                .frame(width: pageNumber == 1 ? 7 : 6)
                                .onTapGesture(perform: {
                                    withAnimation(.easeIn) {
                                        scrollView.scrollTo("home")
                                        pageNumber = 1
                                    }
                                })
                        }
                            Spacer()
                    }
                    
                    VStack{
                        HStack(spacing: 20){
                            Text("Library")
                                .font(.system(size: libraryTextSize))
                                .fontWeight(.bold)
                                .foregroundStyle(.white)
                                .opacity(itemOpacity)
                                .onTapGesture(perform: {
                                    withAnimation(.easeInOut) {
                                        scrollView.scrollTo("library")
                                    }
                                })
                            Spacer()
                        }
                        .padding(.horizontal)
                        Spacer()
                    }
        
                
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHStack(spacing:0){
                        mainView()
                            .frame(width: UIScreen.main.bounds.width)
                            .id("home")
                            
                        libraryView()
                            .frame(width: UIScreen.main.bounds.width)
                            .id("library")
                            
                    }
                    .background(GeometryReader { geometry in
                                        Color.clear
                                            .preference(key: ScrollOffsetPreferenceKey.self, value: geometry.frame(in: .named("scroll")).origin)
                                    })
                                    .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                                        self.scrollPosition = value
                                        libraryTextSize = (2 - (abs(scrollPosition.x) / UIScreen.main.bounds.width)) * 15
                                        itemOpacity = 0.6 + (1 - (abs(scrollPosition.x) / UIScreen.main.bounds.width))
                                        withAnimation(.easeOut) {
                                            if scrollPosition.x >  -UIScreen.main.bounds.width / 2{
                                                pageNumber = 0
                                            } else {
                                                pageNumber = 1
                                            }
                                        }
                                        
                                                
                                    }
                    
                }.scrollTargetBehavior(.paging)
                    .environment(\.layoutDirection, .rightToLeft)
                    .frame(width: .infinity, height: .infinity)
                    .onAppear {
                        UIScrollView.appearance().bounces = false
                    }
                    .coordinateSpace(name: "scroll")
                    .padding(.top, 50)
                
            }.background(
                RadialGradient(gradient:
                                Gradient(colors: [Color(red: 0.6, green: 0.0, blue: 0.5), Color(red: 0.2, green: 0.02, blue: 0.15)]),
                               center: .bottom,
                               startRadius: 0,
                               endRadius: 650)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            )
            
            
        }
    }
    
}




struct libraryView: View {
    var body: some View {
        Color.red
    }
}
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGPoint = .zero

    static func reduce(value: inout CGPoint, nextValue: () -> CGPoint) {
    }
}

#Preview {
    noissy()
       
}
