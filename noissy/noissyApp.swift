//
//  noissyApp.swift


import SwiftUI

@main
struct noissyApp: App {
    @StateObject var model = FeedViewModel()
    @StateObject var CoreModel = CoreDataViewModel()
    
    var body: some Scene {
        WindowGroup {
            noissy(feedViewModel: model, CoreDataVM: CoreModel)
        }
    }
}
