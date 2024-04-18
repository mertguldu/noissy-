//
//  WaveForm.swift
//  noissy
//
//  Created by Mert Guldu on 4/5/24.
//

import SwiftUI
import AVFoundation

struct WaveForm: View {
    var audio: APIResponse
    var videoDuration: Double
    @ObservedObject var feedViewModel: FeedViewModel
    
    @State private var amplitudeValues: [Float] = []
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
            RoundedRectangle(cornerRadius: 10)
                .fill(Color(red: 0.3, green: 0.3, blue: 0.3))
                    .frame(height: height * 0.06)

        }
        .frame(height: height * 0.06)
        .onAppear {
            print("waveform audioURL is changed FFFF")
            
            let channels = audio.channels
            let sampleRateHz = audio.sampleRateHz
            let sampleFrames = audio.sampleFrames
            let audioDuration = audio.duration
            
            
            let encodedData = audio.encodedData
            let data = Data(base64Encoded: encodedData!)
            let url = dataToURL2(data: data! as NSData, url: "waveForm.wav")
                
            getAudioAmplitudes(audioURL: url, channelCount: Int(channels ?? 1), sampleRate: sampleRateHz ?? 1, frameCount: Int(sampleFrames ?? 1), audioDuration: audioDuration ?? 0, videoDuration: videoDuration) { amplitudes in
                        
                amplitudeValues = amplitudes
                            
                let max_amplitude = amplitudeValues.max()
                height_factor = Float((UIScreen.current?.bounds.height ?? 0) * 0.04) / (max_amplitude ?? 1)
            }
        }
        .onChange(of: feedViewModel.selectedFavoritePlayer) { id in
            print("favourite is selected")
            if let id = id {
                amplitudeValues = []
                let feed = feedViewModel.ContentLibrary[id]
                
                print(feed.duration)
                let channels = feed.channels
                let sampleRateHz = feed.sampleRate
                let sampleFrames = feed.sampleFrames
                let audioDuration = feed.duration
                
                
                let data = Data(base64Encoded: (feed.musicData?.base64EncodedString())!)
                if let data = data {
                    print("data yess")
                    let url = dataToURL2(data: data as NSData, url: "selectedWaveForm.wav")
                    
                    getAudioAmplitudes(audioURL: url, channelCount: Int(channels), sampleRate: sampleRateHz, frameCount: Int(sampleFrames), audioDuration: audioDuration, videoDuration: videoDuration) { amplitudes in
                        
                        amplitudeValues = amplitudes
                        
                        let max_amplitude = amplitudeValues.max()
                        height_factor = Float((UIScreen.current?.bounds.height ?? 0) * 0.04) / (max_amplitude ?? 1)
                    }
                }
            }
        }
    }
}


func generateAmplitudes() {
    
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
    @State var audio: APIResponse?
    
    var body: some View {
        VStack {
            if let audio = audio {
               
                WaveForm(audio: audio, videoDuration: 40, feedViewModel: FeedViewModel())
                
            }
        }
        .onAppear {
            Task {
                let audioData = try Data(contentsOf: exampleAudioURL)
                
                audio = APIResponse(encodedData: audioData.base64EncodedString(), channels: 2, sampleRateHz: 44100.0, duration: 71.0, sampleFrames: 440288, error: "dsf")
            }
        }
    }
}

#Preview {
    PreviewWaveForm()
        
}
