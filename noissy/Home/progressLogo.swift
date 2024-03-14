//
//  progressLogo.swift
//  noissy
//
//  Created by Mert Guldu on 3/14/24.
//

import SwiftUI

struct progressLogo: View {
    @State var isAnimating: Bool = false
    
    @State var circleStart: CGFloat = 0.17
    @State var circleEnd: CGFloat = 0.325
    
    @State var rotationDegree: Angle = .degrees(0)
    
    let circleTracGradient = LinearGradient(colors: [Color(red: 0.8, green: 0, blue: 0.8), Color(red: 0.6, green: 0, blue: 0.6)], startPoint: .top, endPoint: .bottom)
    let trackerRotation: Double = 2
    let animationDuration: Double = 0.75
    
    var body: some View {
        ZStack {
            Logo()
            Circle()
                .trim(from: circleStart, to: circleEnd)
                .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round))
                .fill(circleTracGradient)
                .rotationEffect(rotationDegree)
        }
        .frame(width: 200)
        .onAppear {
            animateLoader()
            
            Timer.scheduledTimer(withTimeInterval: (trackerRotation * animationDuration) + animationDuration, repeats: true) { Timer in
                self.animateLoader()
            }
        }
    }
    
    
    func getRotationAngle() -> Angle {
        return .degrees(360 * trackerRotation) + .degrees(120)
    }
    
    func animateLoader() {
        withAnimation(.spring(response: animationDuration * 2)) {
            rotationDegree = .degrees(-57.5)
            circleEnd = 0.325
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(.easeInOut(duration: trackerRotation * animationDuration)) {
                self.rotationDegree += self.getRotationAngle()
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: animationDuration, repeats: false) { _ in
            withAnimation(.easeOut(duration: (trackerRotation * animationDuration) / 2.25)) {
                circleEnd = 0.95
            }
        }
        
        Timer.scheduledTimer(withTimeInterval: trackerRotation * animationDuration, repeats: false) { _ in
            rotationDegree = .degrees(47.5)
            withAnimation(.easeOut(duration: animationDuration)) {
                circleEnd = 0.25
            }
        }
    }
}

#Preview {
    progressLogo()
}
