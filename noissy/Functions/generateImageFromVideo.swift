//
//  generateImageFromVideo.swift
//  noissy
//
//  Created by Mert Guldu on 3/1/24.
//

import Foundation
import CoreGraphics
import AVFoundation
import UIKit

func generateImageFromVideo(videoURL: URL, videoDuration: Double, progress: CGFloat, size: CGSize, completion: @escaping (UIImage) -> ()) {
    DispatchQueue.global(qos: .background).async {
        let asset = AVAsset(url: videoURL)
        let generator = AVAssetImageGenerator(asset: asset)
        
        generator.appliesPreferredTrackTransform = true
        generator.maximumSize = size
        generator.requestedTimeToleranceBefore = CMTime(seconds: 2, preferredTimescale: 600)
        generator.requestedTimeToleranceAfter =  CMTime(seconds: 2, preferredTimescale: 600)
        
        do{
            let time = CMTime(seconds: progress * videoDuration, preferredTimescale: 600)
            let image = try generator.copyCGImage(at: time, actualTime: nil)
            let cover = UIImage(cgImage: image)
            
            DispatchQueue.main.async {
                completion(cover)
            }
        }
        catch let error{
            print("Error generating image: \(error)")
            if let underlyingError = (error as NSError).userInfo[NSUnderlyingErrorKey] as? NSError {
                print("Underlying Error: \(underlyingError)")
            }
        }
    }
}
