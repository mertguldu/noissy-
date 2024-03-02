//
//  HeaderLabel.swift
//  noissy
//
//  Created by Mert Guldu on 2/27/24.
//

import SwiftUI

struct HeaderLabel: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var textIndex = 0
    @State private var texts = ["Creating a Music", "Almost there", "Text 3"]
    
    var body: some View {
        if !feedViewModel.isTaskCompleted {
            Text("Click to upload your video")
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
        } else {
            Text(texts[textIndex])
                .foregroundStyle(.white)
                .font(.headline)
                .fontWeight(.bold)
                .padding(.top)
                .onAppear {
                    startTimer()
                }
        }
    }
    
    func startTimer() {
            // Create a timer that repeats every 5 seconds
            Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
                // Update the text index
                textIndex = (textIndex + 1) % texts.count
            }
        }
}

#Preview {
    HeaderLabel(feedViewModel: FeedViewModel())
}
