//
//  CustomVideoPlayer.swift
//  noissy

// Custom Video Player

import SwiftUI
import AVKit

struct CustomVideoPlayer: UIViewControllerRepresentable {
    var player: AVPlayer
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let controller = AVPlayerViewController()
        controller.player = player
        controller.showsPlaybackControls = false
        controller.allowsPictureInPicturePlayback = true
        controller.exitsFullScreenWhenPlaybackEnds = true
        controller.videoGravity = .resizeAspectFill
        controller.allowsVideoFrameAnalysis = false
        
        loopVideo(player: player)
        
        return controller
    }
    
    func loopVideo(player p: AVPlayer) {
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: p.currentItem, queue: nil) { notification in
            p.seek(to: .zero)
            p.play()
        }
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
}
