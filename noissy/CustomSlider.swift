//
//  CustomSlider.swift
//  noissy
//
//  Created by Mert Guldu on 4/7/24.
//

import SwiftUI

struct CustomSlider: View {
    @Binding var progress: CGFloat
    @State var lastDraggedProgress: CGFloat = 1
    
    let sliderWidth = width * 0.65
    let circleWidth: CGFloat = 20
    
    var body: some View {
        HStack {
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.2, green: 0.2, blue: 0.2))
                    .frame(width: sliderWidth)
                
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(red: 0.8, green: 0.8, blue: 0.8))
                    .frame(width: max(sliderWidth * progress, 0))
            }
            .frame(height: 8)
            .overlay (alignment: .leading) {
                Circle()
                    .fill(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .frame(width: circleWidth, height: circleWidth)
                
                    .contentShape(Rectangle())
                    .offset(x: (sliderWidth - circleWidth/2) * progress)
                    .gesture(
                        DragGesture()
                            .onChanged({ value in
                                let translationX: CGFloat = value.translation.width
                                let calculatedProgress = (translationX / (sliderWidth - circleWidth/2)) + lastDraggedProgress
                                
                                progress = max(min(calculatedProgress, 1), 0)
                            })
                            .onEnded({ value in
                                lastDraggedProgress = progress
                            })
                    )
            }
            .padding(.horizontal, 20)
            Spacer()
            Text("\(Int(100 * progress))")
                .font(.title2)
                .fontWeight(.bold)
                .padding(.horizontal, 20)
        }
        .onAppear {
            //progress = lastDraggedProgress
            lastDraggedProgress = progress
        }
    }
}

struct PreviewCustomSlider: View {
    @State private var progress: CGFloat = .zero
    var body: some View {
        CustomSlider(progress: $progress)
    }
}
#Preview {
    PreviewCustomSlider()
}
