//
//  ContentView.swift
//  noissy
//
//  Created by Mert Guldu on 1/25/24.
//

import SwiftUI

struct ContentView: View {
    @State var logo_isAnimated : Bool = false
    
    var body: some View {
        let button_color = Color(red: 0.4, green: 0, blue: 0.4)
        let inspiration_button = RoundedRectangle(cornerSize: CGSize(width: 15, height: 15))
        VStack{
            HStack(spacing: 20){
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 7)
                Circle()
                    .foregroundStyle(.white)
                    .frame(width: 7)
            }
            Spacer()
            logo_animated()
            Spacer()
            HStack{
                Text("Inspiration")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                Spacer()
            }
            .padding()
            
            VStack(spacing: 30) {
                HStack(spacing:30){
                    inspiration_button
                    inspiration_button
                }
                .foregroundStyle(button_color)
                .frame(height: 60)

                HStack(spacing:30){
                    inspiration_button
                    inspiration_button
                }
                .foregroundStyle(button_color)
                .frame(height: 60)
                
                HStack(spacing:30){
                    inspiration_button
                    inspiration_button
                }
                .foregroundStyle(button_color)
                .frame(height: 60)
            }
            .padding()
            
            
        }
        .background(Color(red: 0.15, green: 0, blue: 0.16))
    }
}

struct logo_animated: View {
    @State var isAnimated: Bool = false
    @State var tapped: Bool = false
    let timing: Double
    
    let maxCounter: Int = 4
    
    let frame: CGSize
    let primaryColor: Color
    
    init(color: Color = .black, size: CGFloat = 200, speed: Double = 0.5) {
        timing = speed * 4
        frame = CGSize(width: size, height: size)
        primaryColor = color
    }
    
    var body: some View {
        ZStack {
            logo()
                .onTapGesture {
                    isAnimated.toggle()
                    tapped.toggle()
                }
                .opacity(tapped ? 0.0 : 1.0)
            
            ForEach(0..<maxCounter) {index in
                logo()
                    .opacity(isAnimated ? 0.0 : 1.0)
                    .scaleEffect(isAnimated ? 1.0 : 0.0)
                    .animation(.easeOut(duration: timing).repeatForever(autoreverses: false).delay(Double(index) * timing / Double(maxCounter)))
            }
        }
        .frame(width: frame.width, height: frame.height, alignment: .top)
    }
}

struct logo: View {
    let logo_width = 20.0
    
    var body: some View {
        VStack{
            ZStack{
                Circle()
                    .fill(Color(red: 0.4, green: 0, blue: 0.4))
                    .frame(width: 200)
                
                Circle()
                    .trim(from: 0.0, to: 0.4)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: logo_width, lineCap: .round))
                    .frame(width: 120)
                
                Circle()
                    .trim(from: 0.0, to: 0.4)
                    .stroke(Color.white, style: StrokeStyle(lineWidth: logo_width, lineCap: .round))
                    .frame(width: 120)
                    .rotationEffect(.degrees(180))
            }
            
        }
    }
}

#Preview {
    ContentView()
       
}
