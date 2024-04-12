//
//  APIResponse.swift
//  noissy
//
//  Created by Mert Guldu on 3/3/24.
//

import Foundation

struct APIResponse: Decodable {
    let encodedData: String?
    let channels: Int?
    let sampleRateHz: Double?
    let duration: Double?
    let sampleFrames: Int?
    let error: String?
}

