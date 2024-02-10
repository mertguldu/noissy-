//
//  noissy.swift
//  noissy
//
//  Created by Mert Guldu on 1/25/24.
//

import SwiftUI

struct noissy: View {
    @State var pageNumber: Int = 1
    @State private var scrollPosition: CGPoint = .zero
    @State var libraryTextSize: CGFloat = 0
    @State var itemOpacity: CGFloat = 0.5
    @State var imageIsSelected: Bool
    
    var body: some View {
        ZStack {
            NavigationView{
                ScrollViewReader { scrollView in
                    ZStack{
                        VStack(spacing:0){
                            HStack(spacing: 20){
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 6)
                                    .opacity(pageNumber == 0 ? 1.0: 0.5)
                                    .onTapGesture(perform: {
                                        withAnimation(.easeIn) {
                                            scrollView.scrollTo("library")
                                            pageNumber = 0
                                        }
                                    })
                                Circle()
                                    .foregroundStyle(.white)
                                    .frame(width: 6)
                                    .opacity(pageNumber == 1 ? 1.0: 0.5)
                                    .onTapGesture(perform: {
                                        withAnimation(.easeIn) {
                                            scrollView.scrollTo("home")
                                            pageNumber = 1
                                        }
                                    })
                            }
                            Spacer()
                        }
                        
                        VStack(spacing:0){
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
                                homeView(imageSelected: $imageIsSelected)
                                    .frame(width: UIScreen.main.bounds.width)
                                    .id("home")
                                
                                libraryView()
                                    .frame(width: UIScreen.main.bounds.width)
                                    .id("library")
                                    .environment(\.layoutDirection, .leftToRight)
                                
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
                            .onAppear {
                                UIScrollView.appearance().bounces = false
                            }
                            .coordinateSpace(name: "scroll")
                            .padding(.top, 65)
                        
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
            
            singleFeedView(imageIsSelected: $imageIsSelected)
                .opacity(imageIsSelected ? 1.0 : 0.0)
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}



#Preview {
    noissy(imageIsSelected: false)
       
}
