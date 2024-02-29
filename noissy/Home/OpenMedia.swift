//
//  OpenMedia.swift
//  noissy
//
//  Created by Mert Guldu on 2/24/24.
//

import AVKit
import PhotosUI
import SwiftUI

struct OpenMedia: View {
    @ObservedObject var feedViewModel: FeedViewModel
    @State private var selectedItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            NavigationStack {
                PhotosPicker(selection: $selectedItem, matching: .videos){
                    Logo()
                }
                    .onChange(of: selectedItem) { _ in
                        Task {
                            do {
                                if let movie = try await selectedItem?.loadTransferable(type: Movie.self) {
                                    let data = NSData(contentsOf: movie.url)!
                                    feedViewModel.selectedContent = data
                                    feedViewModel.isTaskCompleted = true
                                    feedViewModel.add(contentData: data as Data)
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                    }
                    .padding(.top, -200)
                    .photosPickerAccessoryVisibility(.hidden, edges: .bottom)
            }
        }
    }
}

#Preview {
    OpenMedia(feedViewModel: FeedViewModel())
}

