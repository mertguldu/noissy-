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
