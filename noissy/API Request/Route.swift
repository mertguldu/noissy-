//
//  Route.swift
//  noissy


import Foundation

enum Route {
    static let baseUrl = "https://noissy.ai/5000"
    
    case temp //endpoint
    
    var description: String {
        switch self {
        case .temp: return "/tasks"
        }
    }
}
