//
//  noissyApp.swift


import SwiftUI

@main
struct noissyApp: App {
    @StateObject var model = FeedViewModel()
    
    var body: some Scene {
        WindowGroup {
            noissy(feedViewModel: model)

        }
    }
}
