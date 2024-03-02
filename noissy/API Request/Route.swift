//
//  Route.swift
//  noissy


import Foundation

enum Route {
    static let baseUrl = "http://127.0.0.1:5000"
    
    case temp //endpoint
    
    var description: String {
        switch self {
        case .temp: return ""
        }
    }
}
