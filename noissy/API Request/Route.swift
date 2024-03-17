//
//  Route.swift
//  noissy


import Foundation

enum Route {
    static let baseUrl = "https://noissy.ai"
    
    case temp //endpoint
    
    var description: String {
        switch self {
        case .temp: return "/music"
        }
    }
}
