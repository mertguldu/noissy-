//
//  getVideoFPS.swift
//  noissy
//
//  Created by Mert Guldu on 3/9/24.
//

import Foundation
import AVKit

func getVideoFPS(videoURL: URL) async -> Float {
    let asset = AVAsset(url: videoURL)
    let tracks = try? await asset.loadTracks(withMediaType: .video)
    
    if let track = tracks?.first {
        let frameRate = try? await track.load(.nominalFrameRate)
        if let frameRate = frameRate {
            return frameRate
        } else {
            return 1
        }
    } else {
        return 1
    }
}
