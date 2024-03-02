//
//  OpenMedia.swift
//  noissy


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
                                    let cgimage = await generateImageFromVideo(videoUrl: movie.url)
                                    let imageData = UIImage(cgImage: cgimage).pngData()
                                    
                                    feedViewModel.selectedContent = data
                                    feedViewModel.isTaskCompleted = true
                                    if let imgData = imageData {
                                        feedViewModel.add(imageData: imgData, contentData: data as Data)
                                    } else {print("Unable to save image data")}
                                }
                            } catch let error {
                                print(error)
                            }
                        }
                    }
                    .padding(.top, -200)
                    //.photosPickerAccessoryVisibility(.hidden, edges: .bottom)
            }
        }
    }
}

#Preview {
    OpenMedia(feedViewModel: FeedViewModel())
}

