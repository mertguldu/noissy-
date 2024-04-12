//
//  dataToURL.swift
//  noissy
//
//  Created by Mert Guldu on 2/29/24.
//

import Foundation

func dataToURL(data: NSData) -> URL {
    let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("movie\(FeedViewModel().ContentLibrary.count).mp4")
    
    do {
        try data.write(to: cacheURL, options: .atomicWrite)
        
    } catch let error {
        print(error)
    }
    
    return cacheURL
}

func URLToURL(url: String) -> URL {
    let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent("audio.wav")
    
    do {
        try URL(string: url)?.dataRepresentation.write(to: cacheURL)
        
    } catch let error {
        print(error)
    }

    return cacheURL
}

func dataToURL2(data: NSData, url: String) -> URL {
    let cacheURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!.appendingPathComponent(url)
    
    do {
        try data.write(to: cacheURL, options: .atomicWrite)
    } catch let error {
        print(error)
    }
    
    return cacheURL
}

// Function to decode base64 audio data and return the URL of the saved audio file
func createAudioFileFromBase64(base64String: String, fileName: String) -> URL? {
    guard let audioData = Data(base64Encoded: base64String) else {
        print("Error decoding base64 data")
        return nil
    }
    
    let tempDirectory = FileManager.default.temporaryDirectory
    let audioFileURL = tempDirectory.appendingPathComponent(fileName)
    
    do {
        try audioData.write(to: audioFileURL)
        return audioFileURL
    } catch {
        print("Error saving audio file:", error)
        return nil
    }
}
