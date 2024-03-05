//
//  APIResponse.swift
//  noissy
//
//  Created by Mert Guldu on 3/3/24.
//

import Foundation

struct APIResponse<T: Decodable>: Decodable {
    let message: T?
    let error: String?
}

