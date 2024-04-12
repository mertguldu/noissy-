//
//  videoDuration.swift
//  noissy
//
//  Created by Mert Guldu on 4/3/24.
//

import Foundation
import AVFoundation

func videoDuration(videoURL: URL) async -> Double {
    let asset = AVAsset(url: videoURL)
    
    do {
        return try await asset.load(.duration).seconds
    } catch {}
    
    return 0.0
}
