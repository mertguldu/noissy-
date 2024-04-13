//
//  WaveForm.swift
//  noissy
//
//  Created by Mert Guldu on 4/5/24.
//

import SwiftUI
import AVFoundation

struct WaveForm: View {
    var feedViewModel: FeedViewModel
    var audioURL: URL?
    var videoDuration: Double?
    @State var channels: Int?
    @State var sampleRateHz: Double?
    @State var sampleFrames: Int?
    @State var audioDuration: Double?
    
    @State private var amplitudeValues: [Float] = []
    @State private var timelineValues: [TimeInterval] = []  // Stores time values for each sample
    @State private var height_factor: Float = 1.0
    
    let barWidth: CGFloat = 2
    let barSpacing: CGFloat = 2
    let barColor: Color = Color.white
    let imageWidth: Double = thumbNailWidth
    
    var body: some View {
        HStack(spacing: barSpacing) {
            ForEach(amplitudeValues, id: \.self) { amplitude in
                BarView(amplitude: amplitude, barWidth: barWidth, barColor: barColor, height_factor: height_factor)
            }
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                    .fill(.gray)
                    .frame(height: height * 0.06)

        }
        .frame(height: height * 0.06)
        .onAppear {
            if let audio = feedViewModel.generatedMusic {
                channels = audio.channels
                sampleRateHz = audio.sampleRateHz
                sampleFrames = audio.sampleFrames
                audioDuration = audio.duration
            }
            
            if let audioURL = audioURL {
                if let videoDuration = videoDuration {
                    getAudioAmplitudes(audioURL: audioURL, channelCount: channels ?? 1, sampleRate: sampleRateHz ?? 1 , frameCount: sampleFrames ?? 1, audioDuration: audioDuration ?? 0, videoDuration: videoDuration) { amplitudes in
                        
                        amplitudeValues = amplitudes
                            
                        let max_amplitude = amplitudeValues.max()
                        height_factor = Float((UIScreen.current?.bounds.height ?? 0) * 0.03) / (max_amplitude ?? 1)
                    }
                }
            }
        }
    }
}

struct BarView: View {
    let amplitude: Float
    let barWidth: CGFloat
    let barColor: Color
    let height_factor: Float
    
    var body: some View {
        RoundedRectangle(cornerRadius: 50)
            .fill(barColor)
            .frame(width: barWidth, height: CGFloat(abs(amplitude) * height_factor)) // Adjust height as needed
    }
}

struct PreviewWaveForm: View {
    @State private var audioURL: URL?
    var body: some View {
        VStack {
            if let audioURL = audioURL {
                WaveForm(feedViewModel: FeedViewModel(), audioURL: audioURL, videoDuration: 200, channels: 2, sampleRateHz: 44100.0, sampleFrames:  440288, audioDuration: 100)
            }
        }
        .onAppear {
            Task {
                let audioData = try Data(contentsOf: exampleAudioURL)
                audioURL = dataToURL2(data: audioData as NSData, url: "newAu.wav")
            }
        }
    }
}

#Preview {
    PreviewWaveForm()
}
