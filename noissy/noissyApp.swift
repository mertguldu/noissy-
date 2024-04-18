//
//  noissyApp.swift


import SwiftUI

@main
struct noissyApp: App {
    @StateObject var model = FeedViewModel()
    @State var showMenu: Bool = false
    @State var videoVolume: CGFloat = .zero
    var body: some Scene {
        WindowGroup {
            //LikedSongsView(showMenu: $showMenu, feedViewModel: model)
            Noissy(feedViewModel: model)
            //EditMenu(videoVolume: $videoVolume, audioVolume: $videoVolume, feedViewModel: model)
        }
    }
}
