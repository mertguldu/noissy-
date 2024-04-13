//
//  mergeVideoAndAudio.swift
//  noissy
//
//  Created by Mert Guldu on 3/1/24.
//

import UIKit
import AVFoundation
import AVKit
import AssetsLibrary

/// Merges video and sound while keeping sound of the video too
///
/// - Parameters:
///   - videoUrl: URL to video file
///   - audioUrl: URL to audio file
///   - shouldFlipHorizontally: pass True if video was recorded using frontal camera otherwise pass False
///   - completion: completion of saving: error or url with final video
func mergeVideoAudio(videoURL: URL,
                     audioURL: URL,
                     videoVolume: Float,
                     audioVolume: Float,
                        completion: @escaping (_ mergedData:Data?, _ error:Error?) -> Void) async {
    let mixComposition = AVMutableComposition()
    var mutableCompositionVideoTrack = [AVMutableCompositionTrack]()
    var mutableCompositionAudioTrack = [AVMutableCompositionTrack]()
    var mutableCompositionAudioOfVideoTrack = [AVMutableCompositionTrack]()

    //start merge
    let aVideoAsset = AVAsset(url: videoURL)
    let aAudioAsset = AVAsset(url: audioURL)
    
    let audioMix = AVMutableAudioMix()
    
    let compositionAddVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!
    let compositionAddAudio = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!
    let compositionAddAudioOfVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

    let aVideoAssetTrack: AVAssetTrack? = try? await aVideoAsset.loadTracks(withMediaType: AVMediaType.video)[0]
    let aAudioOfVideoAssetTrack: AVAssetTrack? = try? await aVideoAsset.loadTracks(withMediaType: AVMediaType.audio)[0]
    let aAudioAssetTrack: AVAssetTrack? = try? await aAudioAsset.loadTracks(withMediaType: AVMediaType.audio)[0]
    
    mutableCompositionVideoTrack.append(compositionAddVideo)
    mutableCompositionAudioTrack.append(compositionAddAudio)
    mutableCompositionAudioOfVideoTrack.append(compositionAddAudioOfVideo)

    if let videoAssetTrack = aVideoAssetTrack {
        // Default must have tranformation
        do {
            compositionAddVideo.preferredTransform = try await videoAssetTrack.load(.preferredTransform)
        } catch let error {
            print(error)
        }
        
        do {
            try await mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                    duration: videoAssetTrack.load(.timeRange).duration),
                                                                                    of: videoAssetTrack,
                                                                                    at: CMTime.zero)
            if let audioAssetTrack = aAudioAssetTrack {
                // Apply volume adjustment to audio
                let audioInputParams = AVMutableAudioMixInputParameters(track: compositionAddAudio)
                audioInputParams.setVolume(audioVolume, at: .zero)
                audioMix.inputParameters = [audioInputParams]
                                
                // Insert audio with volume adjustment
                try await mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: .zero,
                                                                                        duration: videoAssetTrack.load(.timeRange).duration),
                                                                                        of: audioAssetTrack,
                                                                                        at: .zero)
            } else {
                print("there is no audio in the audio file")
            }
            
            // adding audio (of the video if exists) asset to the final composition
            if let aAudioOfVideoAssetTrack = aAudioOfVideoAssetTrack {
                let audioInputParamsOfVideo = AVMutableAudioMixInputParameters(track: compositionAddAudioOfVideo)
                audioInputParamsOfVideo.setVolume(videoVolume, at: .zero)
                audioMix.inputParameters.append(audioInputParamsOfVideo)
                                
                try await mutableCompositionAudioOfVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: .zero,
                                                                                                duration: videoAssetTrack.load(.timeRange).duration),
                                                                                                of: aAudioOfVideoAssetTrack,
                                                                                                at: .zero)
            } else {
                print("Video does not have an audio")
            }
        } catch {
            print(error.localizedDescription)
        }
    } else {
        print("videoAssetTrack is nil")
    }

    // Exporting
    let savePathUrl: URL = URL(fileURLWithPath: NSHomeDirectory() + "/Documents/newVideo.mp4")
    
    do { // delete old video
        try FileManager.default.removeItem(at: savePathUrl)
    } catch { print(error.localizedDescription) }

    let assetExport: AVAssetExportSession = AVAssetExportSession(asset: mixComposition, presetName: AVAssetExportPresetHighestQuality)!
    assetExport.outputFileType = AVFileType.mp4
    assetExport.outputURL = savePathUrl
    assetExport.shouldOptimizeForNetworkUse = true
    assetExport.audioMix = audioMix
    
    await assetExport.export()
    
    
    do {
        let mergedData = try Data(contentsOf: savePathUrl)
        completion(mergedData, nil)
        print("merging completed")
    } catch {
        print(error.localizedDescription)
    }
}
