//
//  HeaderLabel.swift
//  noissy


import SwiftUI

struct HeaderLabel: View {
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var textIndex = 0
    @State private var texts = ["Creating the Music", "Almost there", "Getting close", "Last few steps"]
    
    var body: some View {
        if !feedViewModel.currentTask {
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
            // Create a timer that repeats every 2 seconds
        Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { timer in
                // Update the text index
                textIndex = (textIndex + 1) % texts.count
            }
        }
}

#Preview {
    HeaderLabel(feedViewModel: FeedViewModel())
}
