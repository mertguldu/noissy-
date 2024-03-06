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
func mergeVideoAndAudio(videoData: String,
                        audioData: String,
                        shouldFlipHorizontally: Bool = false,
                        completion: @escaping (_ mergedData:Data?, _ error:Error?) -> Void) async {

    let mixComposition = AVMutableComposition()
    var mutableCompositionVideoTrack = [AVMutableCompositionTrack]()
    var mutableCompositionAudioTrack = [AVMutableCompositionTrack]()
    var mutableCompositionAudioOfVideoTrack = [AVMutableCompositionTrack]()

    //start merge
    // Decode base64 audio data
    guard let videoDataDecoded = Data(base64Encoded: videoData) else {
        completion(nil, NSError(domain: "YourAppDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode base64 video data"]))
        return
    }
    // Save decoded audio data to a temporary file
    let tempVideoURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempVideo.mp4")
    do {
        try videoDataDecoded.write(to: tempVideoURL)
    } catch {
        completion(nil, NSError(domain: "YourAppDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to write base64 video data"]))
        return
    }
        
    // Decode base64 audio data
    guard let audioDataDecoded = Data(base64Encoded: audioData) else {
        completion(nil, NSError(domain: "YourAppDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to decode base64 audio data"]))
        return
    }
    // Save decoded audio data to a temporary file
    let tempAudioURL = FileManager.default.temporaryDirectory.appendingPathComponent("tempAudio.mp3")
    do {
        try audioDataDecoded.write(to: tempAudioURL)
    } catch {
        completion(nil, NSError(domain: "YourAppDomain", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to write base64 audio data"]))
        return
    }
    
    let aVideoAsset = AVAsset(url: tempVideoURL)
    let aAudioAsset = AVAsset(url: tempAudioURL)
    

    let compositionAddVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)!

    let compositionAddAudio = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

    let compositionAddAudioOfVideo = mixComposition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)!

    let aVideoAssetTrack: AVAssetTrack? = try? await aVideoAsset.loadTracks(withMediaType: AVMediaType.video)[0]
    let aAudioOfVideoAssetTrack: AVAssetTrack? = try? await aVideoAsset.loadTracks(withMediaType: AVMediaType.audio).first
    let aAudioAssetTrack: AVAssetTrack? = try? await aAudioAsset.loadTracks(withMediaType: AVMediaType.audio)[0]

    mutableCompositionVideoTrack.append(compositionAddVideo)
    mutableCompositionAudioTrack.append(compositionAddAudio)
    mutableCompositionAudioOfVideoTrack.append(compositionAddAudioOfVideo)

    if let videoAssetTrack = aVideoAssetTrack {
        do {
            try await mutableCompositionVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                    duration: videoAssetTrack.load(.timeRange).duration),
                                                                                    of: videoAssetTrack,
                                                                                    at: CMTime.zero)
            
            if let audioAssetTrack = aAudioAssetTrack {
                //In my case my audio file is longer then video file so i took videoAsset duration
                //instead of audioAsset duration
                try await mutableCompositionAudioTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                        duration: videoAssetTrack.load(.timeRange).duration),
                                                                                        of: audioAssetTrack,
                                                                                        at: CMTime.zero)
                
            } else {
                print("there is no audio in the audio file")
            }
            
            // adding audio (of the video if exists) asset to the final composition
            if let aAudioOfVideoAssetTrack = aAudioOfVideoAssetTrack {
                try await mutableCompositionAudioOfVideoTrack[0].insertTimeRange(CMTimeRangeMake(start: CMTime.zero,
                                                                                                duration: videoAssetTrack.load(.timeRange).duration),
                                                                                                of: aAudioOfVideoAssetTrack,
                                                                                                at: CMTime.zero)
                
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

    
    let outputURL = assetExport.outputURL
    await assetExport.export()
    
    if let url = outputURL {
        do {
            let mergedData = try Data(contentsOf: url)
            completion(mergedData, nil)
            print("merging completed")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

