//
//  prepareAudioPlayer.swift
//  noissy
//
//  Created by Mert Guldu on 4/6/24.
//

import Foundation
import AVFAudio

func prepareAudioPlayer(audioURL: URL, completion: @escaping (AVAudioPlayer) -> Void) throws {
    let audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
    audioPlayer.prepareToPlay()
    audioPlayer.numberOfLoops = 0
    
    completion(audioPlayer)
}
