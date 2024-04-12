//
//  generateImages.swift
//  noissy
//
//  Created by Mert Guldu on 4/6/24.
//

import Foundation
import UIKit
import AVFoundation

func generateImages(videoURL: URL, duration: Double, size:CGSize, completion: @escaping (UIImage) -> Void) async{

    let parts = (duration / Double(numberOfThumbNail))
    
    (0..<numberOfThumbNail).forEach{ index in
        let progress = (CGFloat(index) * parts) / duration
        
        generateImageFromVideo(videoURL: videoURL, videoDuration: duration, progress: progress, size: size) { image in
            
            completion(image)
        }
    }
}


