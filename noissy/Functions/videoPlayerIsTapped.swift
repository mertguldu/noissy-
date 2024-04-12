//
//  videoPlayerIsTapped.swift
//  noissy
//
//  Created by Mert Guldu on 4/6/24.
//

import Foundation
import AVFoundation

func videoPlayerIsTapped(isPlaying: Bool, player: AVPlayer, audioPlayer: AVAudioPlayer?, progress: CGFloat?, completion: @escaping (Bool) -> Void) {
    if isPlaying {
        player.pause()
        audioPlayer?.pause()
       
        completion(false)
    } else {
        player.play()
        let currentTime = player.currentItem!.duration.seconds * (progress ?? 0)
        if audioPlayer?.duration ?? 0 > currentTime {
            audioPlayer?.currentTime = currentTime
            audioPlayer?.play()
        }
        
        completion(true)
    }
}
