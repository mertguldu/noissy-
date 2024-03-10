//
//  generateImageFromVideo.swift
//  noissy
//
//  Created by Mert Guldu on 3/1/24.
//

import Foundation
import CoreGraphics
import AVFoundation

func generateImageFromVideo(videoUrl: URL) async -> CGImage? {
    let asset = AVAsset(url: videoUrl)
    let generator = AVAssetImageGenerator(asset: asset)
    
    generator.maximumSize = CGSize(width: 300, height: 0)
    generator.appliesPreferredTrackTransform = true
    // Configure the generator's time tolerance values.
    generator.requestedTimeToleranceBefore = .zero
    generator.requestedTimeToleranceAfter = CMTime(seconds: 2, preferredTimescale: 600)
    
    // Generate an image at time zero. Access the image alone.
    do {
        let image = try await generator.image(at: .zero).image
        return image
    } catch let error {
        print(error)
    }
    
    return nil
}
