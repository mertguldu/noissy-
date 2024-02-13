//
//  noissy.swift
//  noissy
//
//  Created by Mert Guldu on 1/25/24.
//

import SwiftUI

struct noissy: View {
    var body: some View {
        ZStack {
            NavigationView{
                ScrollViewReader { scrollView in
                    ZStack {
                        noissyHeader()
                        ScrollView(.horizontal, showsIndicators: false) {  containerView(feedViewModel: FeedViewModel())  }
                            .scrollTargetBehavior(.paging)
                            .environment(\.layoutDirection, .rightToLeft)
                            .onAppear { UIScrollView.appearance().bounces = false }
                            .coordinateSpace(name: "scroll")
                            .padding(.top, 70)
                    }
                    .background(  RadialGradient(gradient:Gradient(colors: [Color(red: 0.6, green: 0.0, blue: 0.5), Color(red: 0.2, green: 0.02, blue: 0.15)]), center: .bottom, startRadius: 0, endRadius: 650)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)   )
                }
            }
            
            //Single Feed View Implementation
            
            
        }
        .edgesIgnoringSafeArea(.all)
    }
    
}

struct containerView: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @State var pageNumber: Int = 1
    @State private var scrollPosition: CGPoint = .zero
    @State var libraryTextSize: CGFloat = 0
    @State var itemOpacity: CGFloat = 0.5
    
    var body: some View {
        LazyHStack(spacing:0){
            homeView(feedViewModel: feedViewModel)
                .frame(width: UIScreen.main.bounds.width)
                .id("home")
            
            libraryView(feedViewModel: feedViewModel)
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
        
    
    }
}

struct CircleIndicator: View {
    let color: Color
    var body: some View {
        Circle()
            .foregroundStyle(.white)
            .frame(width: 8)
    }
}

struct PageIndicator: View {
    var body: some View {
        HStack(alignment:.center, spacing: 20){
            CircleIndicator(color: .white)
                .onTapGesture(perform: {
                    print("page indicator 1")
                })
            
            CircleIndicator(color: .white)
                .onTapGesture(perform: {
                    print("page indicator 2")
                })
        }
    }
}

struct noissyHeader: View {
    var body: some View {
        VStack{
            ZStack {
                HStack {
                    Text("Library")
                        .fontWeight(.bold)
                        .foregroundStyle(.white)
                        .onTapGesture(perform: {
                            print("Library is clicked")
                        })
                    Spacer()
                }
                .padding()
    
                PageIndicator()
            }
            Spacer()
        }
    }
}


#Preview {
    noissy()
       
}
