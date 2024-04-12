//
//  updatePlayerTime.swift
//  noissy
//
//  Created by Mert Guldu on 4/11/24.
//

import Foundation
import AVFoundation

func updatePlayerTime(value: ScrollOffsetKey.Value, player: AVPlayer, audioPlayer: AVAudioPlayer, duration: Double, isPlaying: Bool, completion: @escaping (Double) -> Void) {
    let progress = value / (thumbNailWidth * CGFloat(numberOfThumbNail))
    completion(progress)
    
    if !isPlaying {
        let seekTime = CMTime(seconds: duration * progress, preferredTimescale: 600)
        player.seek(to: seekTime, toleranceBefore: .zero, toleranceAfter: .zero)
        // Update audio player progress
        audioPlayer.currentTime = seekTime.seconds
    }
}
