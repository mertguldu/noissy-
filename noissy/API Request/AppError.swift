//
//  AppError.swift
//  noissy

import Foundation

enum AppError: LocalizedError {
    case errorDecoding
    case unkownError
    case invalidURL
    case serverError(String)
    
    var errorDescription: String? {
        switch self {
            
        case .errorDecoding:
            return "Response could not be decoded"
        case .unkownError:
            return "unkown error"
        case .invalidURL:
            return "invalid URL"
        case .serverError(let error):
            return error
        }
    }
}
