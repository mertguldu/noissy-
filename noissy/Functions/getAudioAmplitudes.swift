//
//  getAudioAmplitudes.swift
//  noissy
//
//  Created by Mert Guldu on 4/5/24.
//

import SwiftUI
import AVFoundation

func getAudioAmplitudes(audioURL: URL, channelCount: Int, sampleRate: Double , frameCount: Int, audioDuration: Double, videoDuration: Double, completion: @escaping ([Float]) -> () ) {
    DispatchQueue.global(qos: .background).async {
    if FileManager.default.fileExists(atPath: audioURL.path) {
        do {
            
            let audioFile = try AVAudioFile(forReading: audioURL)
            let audioFormat = AVAudioFormat(commonFormat: .pcmFormatFloat32,
                                            sampleRate: sampleRate,
                                            channels: AVAudioChannelCount(channelCount),
                                            interleaved: false)
            
            guard let audioPCMBuffer = AVAudioPCMBuffer(pcmFormat: audioFormat!, frameCapacity: AVAudioFrameCount(frameCount)) else {
                print("Error: Unable to create PCM buffer")
                return
            }
            try audioFile.read(into: audioPCMBuffer)
            guard let floatChannelData = audioPCMBuffer.floatChannelData else {
                print("Error: Unable to get float channel data")
                return
            }
            
            let frameDuration: Double = videoDuration / 20
            let audioToFrameNumber = audioDuration / frameDuration
            
            let frameLength = thumbNailWidth
            let audioLength = frameLength * audioToFrameNumber
            
            let numberOfBars = floor(audioLength / 4) - 1 // barwidth + space
            
            var amplitudes: [Float] = []
            let value = ceil(Double(frameCount) / numberOfBars)
            let decimationFactor = Int(max(value, 1))  // Example decimation factor (adjust as needed)
            let adjustedFrameCount = audioDuration > videoDuration ? Double(frameCount) * (videoDuration / audioDuration) : Double(frameCount)
            
            for index in stride(from: 0, to: Int(adjustedFrameCount), by: decimationFactor) {
                var sum: Float = 0
                let endIndex = min(index + decimationFactor, Int(frameCount))
                
                for i in index..<endIndex {
                    sum += floatChannelData[0][i]
                }
                
                let average = sum / Float(decimationFactor)
                amplitudes.append(average)
            }
            
            DispatchQueue.main.async {
                completion(amplitudes)
            }
        } catch {
            print("Error reading audio file: \(error)")
        }
    } else {
        print("file does not exist")
    }
    }
}
